# Número de hilos (threads) mínimos y máximos
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Puerto en el que Puma escuchará las solicitudes
port ENV.fetch("PORT") { 3000 }

# Permitir reinicio de Puma con `bin/rails restart`
plugin :tmp_restart

# Configuración del archivo de PID
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]

# Número de procesos de trabajo (workers), generalmente 1 en entornos de baja memoria
workers ENV.fetch("WEB_CONCURRENCY") { 1 }

# Deshabilitar la precarga de la aplicación para evitar problemas de memoria
# Comenta `preload_app!` si lo tienes habilitado
# preload_app!
