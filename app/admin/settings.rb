ActiveAdmin.register Setting do
  menu priority: 6

  permit_params :key, :value
  actions :all, except: [:destroy]

  filter :key
  filter :value

  member_action :reset_cache, method: :patch do
    setting = Setting.find(params[:id])
    Rails.cache.delete(setting.key)

    redirect_to resource_path(params[:id]), notice: "Refreshed cache for key '#{setting.key}'"
  end

  index download_links: false do
    selectable_column
    id_column
    column :key
    column :value
    column 'Cache' do |setting|
      form_for setting, url: reset_cache_admin_setting_path(setting.id) do |f|
        f.submit 'Reset'
      end
    end

    actions
  end

  form do |f|
    f.inputs do
      f.input :key
      f.input :value
    end
    f.actions
  end

  show do
    attributes_table do
      row :key
      row :value
    end
  end
end
