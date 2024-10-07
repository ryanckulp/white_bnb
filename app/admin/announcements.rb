ActiveAdmin.register Announcement do
  menu priority: 7

  permit_params :title, :body, :version, :date, :published

  actions :all, except: []

  filter :title
  filter :date
  filter :published
  filter :created_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :title
    column 'body', &:body.to_s
    column :date
    column :published
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :title
      row :version
      row :body
      row :date
      row :published
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :title
      f.input :version
      div do
        label 'Body'
        f.rich_text_area :body
      end
      f.input :date
      f.input :published
    end
    f.actions
  end
end
