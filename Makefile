PACKAGES= \
MyRadPlasmaAurora \

INSTALL_DIRS= \
~/.local/share/aurorae/themes/MyRadPlasmaAurora \

METADATA_FILES=$(addsuffix /metadata.desktop,$(PACKAGES))
PACKAGE_ARTIFACT_NAMES:= $(shell cat ${METADATA_FILES} | grep -P 'PluginInfo\-(Name|Version)' | awk -F = '{ print $$2 }' | paste -d'_' - - | awk '{ print $$0 ".tar.gz" }')

$(info $$METADATA_FILES is [${METADATA_FILES}])
$(info $$PACKAGE_ARTIFACT_NAMES is [${PACKAGE_ARTIFACT_NAMES}])

package : ${PACKAGE_ARTIFACT_NAMES}
	@echo 'Packaged :3'

%.tar.gz : 
	@echo $* | awk -F _ '{ print $$1 }' | tar -czvf $@ -T -

PHONY : clean install uninstall

install : ${INSTALL_DIRS}
	@echo 'Installed :3'

$(INSTALL_DIRS) :
	mkdir -p $@
	PACKAGE_NAME=$(notdir $@) ; cp -R "$$PACKAGE_NAME/." $@

uninstall :
	rm -rf ${INSTALL_DIRS}

clean :
	rm -f ${PACKAGE_ARTIFACT_NAMES}
