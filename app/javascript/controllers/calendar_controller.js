import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar"
export default class extends Controller {
  static values = { startDate: String, endDate: String, pricePerNight: Number }

  connect() {
    console.log('Calendar JS connected')
    this.startDateValue = localStorage.getItem('bnb_start_date');
    this.endDateValue = localStorage.getItem('bnb_end_date');
    this.highlightDates();
    localStorage.clear('bnb_start_date');
    localStorage.clear('bnb_end_date');
  }

  resetStartEnd() {
    if (this.startDateValue && this.endDateValue) {
      this.startDateValue = ''
      this.endDateValue = ''
    }
  }

  disconnect() { // if user skips between months, firing disconnect/connect, save start date
    localStorage.setItem('bnb_start_date', this.startDateValue);
    localStorage.setItem('bnb_end_date', this.endDateValue);
  }

  highlightDates() {
    // clear out previous dates
    Array.from(document.querySelectorAll('td.day')).forEach(function(d){ d.classList.remove('bg-green-300')});

    // set start/end dates
    [this.startDateValue, this.endDateValue].forEach((function(d) {
      if (document.getElementById(d)) { document.getElementById(d).classList.add('bg-green-300')}
    }))

    // set dates between start/end
    let betweenDates = this.betweenDates(this.startDateValue, this.endDateValue)
    betweenDates.forEach(function(d) {
      if (document.getElementById(d)) {
        document.getElementById(d).classList.add('bg-green-300')
      }
    })
  }

  betweenDates(startDate, endDate, steps = 1) {
    const dateArray = [];
    let currentDate = new Date(startDate);

    while (currentDate <= new Date(endDate)) {
      dateArray.push(new Date(currentDate));
      // Use UTC date to prevent problems with time zones and DST
      currentDate.setUTCDate(currentDate.getUTCDate() + steps);
    }

    return dateArray.map(d => d.toISOString({timeZone: "America/New_York"}).split('T')[0]);
  }

  saveDate() {
    if (Array.from(event.currentTarget.classList).includes('has-events')) {
      this.resetStartEnd()
      alert('Cannot select a date that is already booked')
      return;
    }

    this.resetStartEnd();

    let day = event.currentTarget.id;
    let dates = [new Date(day), new Date(this.startDateValue), new Date(this.endDateValue)].filter(Boolean).filter(d => !isNaN(d));

    let startDate = new Date(Math.min.apply(null,dates));
    let endDate = new Date(Math.max.apply(null,dates));

    this.startDateValue = startDate.toISOString({timeZone: "America/New_York"}).split('T')[0];

    if (startDate.toDateString() != endDate.toDateString()) {
      this.endDateValue = endDate.toISOString({timeZone: "America/New_York"}).split('T')[0];
    }

    this.highlightDates();
    this.presentDates();
  }

  presentDates() {
    start_date.innerText = this.startDateValue;
    end_date.innerText = this.endDateValue;

    let timeDiff = new Date(this.endDateValue).getTime() - new Date(this.startDateValue).getTime();
    let daysDiff = Math.round(timeDiff / (1000 * 3600 * 24));
    if (daysDiff > 0) { price_calculation.innerText = `(${daysDiff} nights * $${this.pricePerNightValue} /night) => $${daysDiff * this.pricePerNightValue}` };
  }

  createBooking() {
    fetch('/bookings', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ booking: { start_date: this.startDateValue, end_date: this.endDateValue } } )
    })
    .then(response => response.json())
    .then(json => {
      if (json.status == 'created') {
        window.location.href = '/addons'
      } else {
        alert('Something went wrong, please try again')
      }
    });
  }
}
