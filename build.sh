
pip install -r requirements.txt

echo "Applying database migrations..."
python3 manage.py makemigrations --noinput
python3 manage.py migrate --noinput || { echo "Database migration failed"; exit 1; }


SUPERUSER_USERNAME="admin"
SUPERUSER_EMAIL="admin@gmail.com"
SUPERUSER_PASSWORD="admin"

create_superuser() {
    echo "Creating superuser account..."
    python3 manage.py shell <<EOF
from django.contrib.auth.models import User

# Check if the superuser already exists
if not User.objects.filter(username='${SUPERUSER_USERNAME}').exists():
    # Create superuser
    User.objects.create_superuser('${SUPERUSER_USERNAME}', '${SUPERUSER_EMAIL}', '${SUPERUSER_PASSWORD}')
    print('Superuser created successfully.')
else:
    print('Superuser already exists.')
EOF
}

# Apply database migrations with error handling

# Create superuser account
create_superuser
python3 manage.py collectstatic --clear --noinput
python3 manage.py collectstatic --noinput

# mkdir -p /opt/render/project/src/static
# echo "Collecting static files..."
# python3 manage.py collectstatic --noinput
