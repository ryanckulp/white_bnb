ActiveAdmin.register Review do
  menu priority: 6

  permit_params :title, :body, :name, :job_title, :email, :approved

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :title
  filter :body
  filter :name
  filter :job_title
  filter :email
  filter :approved
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :title
    column :body
    column :name
    column :job_title
    column :email
    column :approved
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :title
      row :body
      row :name
      row :job_title
      row :email
      row :approved
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :title
      f.input :body
      f.input :name
      f.input :job_title
      f.input :email
      f.input :approved
    end
    f.actions
  end
end
