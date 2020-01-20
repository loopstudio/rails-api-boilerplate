module WithStatsScopes
  def this_month
    now = Time.current
    where(created_at: now.beginning_of_month..now.end_of_month)
  end
end
