# Nombre del módulo (sin extensión)
obj-m := memory.o

# Directorio con el código fuente del kernel
KDIR := /lib/modules/$(shell uname -r)/build

# Directorio actual
PWD := $(shell pwd)

# Compilar el módulo
all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

# Limpiar archivos generados
clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

# Cargar y descargar el módulo
run: all
	su -c "/sbin/insmod memory.ko"
	su -c "dmesg | tail -n 10"
	sleep 2
	su -c "/sbin/rmmod memory"
	su -c "dmesg | tail -n 10"
