setup-ide:
	php artisan ide-helper:generate
	php artisan ide-helper:models --nowrite
	php artisan ide-helper:meta

setup-debugbar:
	php artisan vendor:publish --provider='Fruitcake\LaravelDebugbar\ServiceProvider'

setup-permissions:
	php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
	php artisan config:clear
	php artisan migrate