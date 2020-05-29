echo "Running Release Tasks"

if [ "$MIGRATIONS_ON_RELEASE" == "true" ]; then
  echo "Running Migrations"
  bundle exec rails db:migrate
fi

if [ "$SEED_ON_RELEASE" == "true" ]; then
  echo "Seeding DB"
  bundle exec rails db:seed
fi

echo "Done running release_tasks.sh"
