ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :password

  actions :all

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name

    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :created_at

  show do
    tabs do
      tab I18n.t('active_admin.overview') do
        panel I18n.t('active_admin.general') do
          attributes_table_for user do
            row :id
            row :email
            row :first_name
            row :last_name
          end
        end

        panel I18n.t('active_admin.session_info') do
          attributes_table_for user do
            row :provider
            row :sign_in_count
            row :last_sign_in
            row :created_at
            row :updated_at
          end
        end
      end
    end
  end

  form do |f|
    f.inputs do
      if f.object.new_record?
        f.input :email
        f.input :first_name
        f.input :last_name
      else
        f.input :email, input_html: { disabled: true }
      end
      f.input :password
    end

    actions
  end
end
