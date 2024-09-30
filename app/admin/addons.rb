ActiveAdmin.register Addon do
  menu priority: 4

  # Specify parameters which should be permitted for assignment
  permit_params :title, :description, :price

  # or consider:
  #
  # permit_params do
  #   permitted = [:title, :description, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :title
  filter :description
  filter :price
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :title
    column :description
    column :price
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :title
      row :description
      row :price
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :title
      f.input :description
      f.input :price
    end
    f.actions
  end
end
