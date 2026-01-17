# 📡 Telegraph Simulator

Un simulador interactivo de red de telegrafía desarrollado en **Swift**. Este proyecto modela la transmisión de mensajes codificados en Morse a través de una red física con degradación de señal y gestión de hardware.

## 🚀 Funcionalidades
- **Codificación Morse**: Traducción de texto a pulsos de señal.
- **Simulación Física**: Cálculo de pérdida de intensidad por kilómetro y tipo de cable.
- **Consola Interactiva**: Menú de comandos para operar el sistema en tiempo real.
- **Gestión de Energía**: Control manual de encendido/apagado del emisor.

## ⌨️ Guía de Comandos
Al ejecutar el programa, puedes usar:
- `enviar`: Para redactar y transmitir un mensaje.
- `on` / `off`: Para activar o desactivar el emisor.
- `status`: Para comprobar el estado actual del hardware.
- `salir`: Para cerrar el simulador.

## 📦 Estructura del Proyecto
- **Models**: Definición de `Signal` y tipos de error.
- **Protocols**: Contratos para emisores, receptores y transmisores.
- **Components**: Implementación física de los componentes del sistema: emisor, receptor, decodificador, cables y relés.
- **System**: El `TelegraphCoordinator` que orquesta la comunicación.

## 🔧 Instalación y Ejecución

1. **Clona el repositorio** en tu equipo local.
2. **Abre el proyecto** haciendo doble clic en el archivo con extensión `.xcodeproj` en **Xcode**.
3. **Selecciona el target** `TelegraphSimulator` en la barra de herramientas superior.
4. **Pulsa `Cmd + R`** para compilar y ejecutar el simulador directamente en la consola de Xcode.
