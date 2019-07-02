
ifdef CONFIG_EXTERNAL_LIBMODBUS

# Targets provided by this project
.PHONY: libmodbus clean_libmodbus

# Add this to the "external" target
external: libmodbus
clean_external: clean_libmodbus

MODULE_DIR_LIBMODBUS=external/optional/libmodbus
LIBMODBUS_VERSION="3.14"

libmodbus: 
	@cd $(MODULE_DIR_LIBMODBUS) && ./autogen.sh 
	@cd $(MODULE_DIR_LIBMODBUS) && ./configure --prefix=$(shell pwd)/out
	@echo
	@echo "==== Installing LIBMODBUS Library ($(LIBMODBUS_VERSION)) ===="
	@echo " Using GCC    : $(CC)"
	@echo " Target flags : $(TARGET_FLAGS)"
	@echo " Sysroot      : $(PLATFORM_SYSROOT)"
	@echo " BOSP Options : $(CMAKE_COMMON_OPTIONS)"
	@cd $(MODULE_DIR_LIBMODBUS) && \
	        make -j$(CPUS) install || \
	        exit 1

clean_libmodbus:
	@echo "==== Clean-up LIBMODBUS library ===="
	@[ ! -f $(BUILD_DIR)/lib/libmodbus.so ] || \
		rm -f $(BUILD_DIR)/lib/libmodbus*
	@cd $(MODULE_DIR_LIBMODBUS) && \
		make distclean

else # CONFIG_EXTERNAL_LIBMODBUS

libmodbus:
	$(warning $(MODULE_DIR_LIBMODBUS) module disabled by BOSP configuration)
	$(error BOSP compilation failed)

endif # CONFIG_EXTERNAL_LIBMODBUS

