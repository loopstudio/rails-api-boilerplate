ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end

    def print_stats(relation)
      total = relation.count
      this_month = relation.extending(WithStatsScopes).this_month.count
      para("Total: #{total}")
      para("Created this month: #{this_month}")
    end

    columns do
      column do
        panel 'Users' do
          print_stats(User)
        end
      end
    end
  end
end
