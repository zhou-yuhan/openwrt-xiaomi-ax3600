include $(TOPDIR)/rules.mk

# Name, version and release number
# The name and version of your package are used to define the variable to point to the build directory of your package: $(PKG_BUILD_DIR)
PKG_NAME:=zhuge
PKG_VERSION:=0.1
PKG_RELEASE:=1


# Source settings (i.e. where to find the source codes)
# This is a custom variable, used below
SOURCE_DIR:=/home/yuhan/Documents/wifi/zhuge

include $(INCLUDE_DIR)/package.mk

# Package definition; instructs on how and where our package will appear in the overall configuration menu ('make menuconfig')
define Package/zhuge
  SECTION:=rt_streaming
  CATEGORY:=RT_Streaming
  TITLE:=Zhuge (SIGCOMM 2022) implementation
  DEPENDS:=+libstdcpp
endef

# Package description; a more verbose description on what our package does
define Package/zhuge/description
  Zhuge (SIGCOMM 2022) implementation
endef

# Package preparation instructions; create the build directory and copy the source code. 
# The last command is necessary to ensure our preparation instructions remain compatible with the patching system.
define Build/Prepare
		mkdir -p $(PKG_BUILD_DIR)
		cp -r $(SOURCE_DIR)/* $(PKG_BUILD_DIR)
		$(Build/Patch)
endef

# Package build instructions; invoke the target-specific compiler to first compile the source file, and then to link the file into the final executable
define Build/Compile
		$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CXX)" \
		CFLAGS="$(TARGET_CXXFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef

# Package install instructions; create a directory inside the package to hold our executable, and then copy the executable we built previously into the folder
define Package/zhuge/install
		$(INSTALL_DIR) $(1)/usr/bin
		$(INSTALL_BIN) $(PKG_BUILD_DIR)/zhuge $(1)/usr/bin
endef

# This command is always the last, it uses the definitions and variables we give above in order to get the job done
$(eval $(call BuildPackage,zhuge))
