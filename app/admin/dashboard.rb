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
      para("#{I18n.t('active_admin.total')}: #{total}")
      para("#{I18n.t('active_admin.this_month')}: #{this_month}")
    end

    columns do
      column do
        panel I18n.t('activerecord.models.user.other') do
          print_stats(User)
        end

        panel I18n.t('active_admin.charts.sign_ups_per_month') do
          render 'sign_ups_per_month', { users: User.group_by_month(:created_at).count }
        end
      end
    end
  end
end
