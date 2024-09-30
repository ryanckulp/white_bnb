ActiveAdmin.register Booking do
  menu priority: 3

  # Specify parameters which should be permitted for assignment
  permit_params :start_date, :end_date, :notes, :stripe_payment_id_id, :user_id

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :start_date
  filter :end_date
  filter :stripe_payment_id
  filter :user
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :start_date
    column :end_date
    column :stripe_payment_id
    column :user
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :start_date
      row :end_date
      row :stripe_payment_id
      row :user
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :start_date
      f.input :end_date
      f.input :notes, as: :text, input_html: { rows: 8 }
      f.input :stripe_payment_id, label: 'Stripe Payment ID', placeholder: 'ch_asdfqwerty1234'
      f.input :user, as: :select, collection: User.all.map { |u| [u.email, u.id] }, include_blank: 'Please select...'
    end
    f.actions
  end
end
