# Manual de instalación y ejecución

## Requisitos previos

Para la correcta ejecución de la aplicación se requiere la instalación de los siguientes componentes:

- **Git**: herramienta necesaria para clonar el repositorio del proyecto. Puede descargarse desde [git-scm.com](https://git-scm.com/downloads).
- **Conda**: (Anaconda o Miniconda) utilizada para la gestión de entornos virtuales. Descargas disponibles en [Miniconda](https://docs.conda.io/en/latest/miniconda.html) y [Anaconda](https://www.anaconda.com/download).
- **XAMPP**: paquete que incluye MySQL/MariaDB y phpMyAdmin, requerido para la gestión de la base de datos. Disponible en [apachefriends.org](https://www.apachefriends.org/es/index.html).
- **Drivers NVIDIA y CUDA**: necesarios únicamente en caso de utilizar GPU con PyTorch. Disponibles en [developer.nvidia.com](https://developer.nvidia.com/cuda-downloads).

---

## Clonación del repositorio

En primer lugar, se clona el repositorio y se accede a la carpeta del proyecto:

```bash
git clone https://github.com/Ivanlpc/app-tfg
cd app-tfg
```

---

## Creación de entornos Conda

Se crean tres entornos virtuales, cada uno con una versión específica de Python:

```bash
conda create -n app python=3.10
conda create -n model python=3.7
conda create -n postprocess python=3.8
```

En sistemas Windows se deberán abrir tres instancias de *Anaconda Prompt*, mientras que en Linux bastará con tres terminales distintas. Posteriormente se activan los entornos:

- **Terminal 1**: ```conda activate app```
- **Terminal 2**: ```conda activate model```
- **Terminal 3**: ```conda activate postprocess```

---

## Uso de GPU

En caso de disponer de una GPU compatible, se puede comprobar su disponibilidad ejecutando en PowerShell:

```bash
nvidia-smi
```

El comando muestra la versión de CUDA instalada. Según la documentación de [PyTorch](https://pytorch.org/get-started/locally/), se instalan los paquetes adecuados.

### Ejemplo con CUDA 12.8

- **Terminal model**:
  ```bash
  pip install torch torchvision --index-url https://download.pytorch.org/whl/cu128
  ```

- **Terminal postprocess**:
  ```bash
  pip install torch torchvision --index-url https://download.pytorch.org/whl/cu128
  ```

Si no se desea utilizar GPU, se procede a la instalación de PyTorch para CPU en ambas terminales:

```bash
pip install torch torchvision
```
---

## Instalación de dependencias

Las dependencias necesarias se instalan en cada entorno siguiendo los pasos descritos:

- **Terminal app**:
  ```bash
  cd app-tfg/app
  pip install -r requirements.txt
  ```

- **Terminal model**:
  ```bash
  cd app-tfg/model
  cd reid
  pip install -r requirements.txt
  pip install https://github.com/KaiyangZhou/deep-person-reid/archive/master.zip
  cd ..
  ```

- **Terminal postprocess**:
  ```bash
  cd app-tfg/postprocess
  pip install -r requirements
  pip install https://github.com/KaiyangZhou/deep-person-reid/archive/master.zip
  ```

---

## Carga de pesos del modelo

Los pesos de los modelos se encuentran en la carpeta de Google Drive disponible en el siguiente [enlace](https://drive.google.com/drive/folders/1euv4tgcilZfMnJgFKmCJ6UKcaZ7TRnjh?usp=sharing).

Se ofrecen dos versiones:
- Modelo *ReID* entrenado sobre el dataset *SportsMOT*.
- Modelo *ReID* entrenado con vídeos propios.

Los archivos deben colocarse en las siguientes rutas:

- ```model/checkpoints/best_ckpt.pth.tar```
- ```model/checkpoints/sports_model.pth.tar-60```
- ```postprocess/reid_checkpoints/sports_model.pth.tar-60```

---

## Base de datos

La base de datos utilizada es **MySQL**, incluida en el paquete **XAMPP**.

### Inicio de XAMPP
1. Abrir el *Panel de Control de XAMPP*.
2. Iniciar el servicio **MySQL**.
3. Opcionalmente, iniciar **Apache** para acceder a **phpMyAdmin**.

### Acceso a phpMyAdmin
- Pulsar el botón *Admin* en la fila correspondiente a **MySQL**.
- También se puede acceder mediante navegador en la URL:

  ```bash
  http://localhost/phpmyadmin/
  ```

### Importación de la base de datos
1. En phpMyAdmin, acceder a la pestaña **Importar**.
2. Seleccionar el archivo ```restore.sql``` incluido en el proyecto.
3. Pulsar **Continuar** para ejecutar el script de creación de tablas.

---

## Ejecución de la aplicación

Finalmente, una vez instaladas las dependencias y configurada la base de datos, se ejecuta la aplicación. En cada una de las tres terminales abiertas (**app**, **model** y **postprocess**) se ejecuta:

```bash
python app.py
```
