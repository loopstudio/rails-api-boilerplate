module WithStatsScopes
  def this_month
    where(created_at: Time.current.all_month)
  end
end
