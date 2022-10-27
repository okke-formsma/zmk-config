board=nrfmicro_11_flipped
keymap=default
shield=arch36
config_dir=~/dev/zmk-config/config
zmk_dir=~/dev/zmk/app
ZEPHYR_BASE=~/dev/zmk/app


.PHONY: build-left build-left-config build-right build-right-config flash
build-left:
	cd ${zmk_dir} && west build -b ${board} -d build/${shield}_left --pristine -- -DSHIELD=${shield}_left -DZMK_CONFIG=${config_dir}
build-right:
	cd ${zmk_dir} && west build -b ${board} -d build/${shield}_right --pristine -- -DSHIELD=${shield}_right -DZMK_CONFIG=${config_dir}

flash-left: 
	printf "Put device in dfu mode"
	while [ ! -f /media/${USER}/NRF52BOOT/current.uf2 ]; do sleep 1; printf "."; done; printf "\n"
	cp ${zmk_dir}/build/${shield}_left/zephyr/zmk.uf2 /media/${USER}/NRF52BOOT/

flash-right: 
	printf "Put device in dfu mode"
	while [ ! -f /media/${USER}/NRF52BOOT/current.uf2 ]; do sleep 1; printf "."; done; printf "\n"
	cp ${zmk_dir}/build/${shield}_right/zephyr/zmk.uf2 /media/${USER}/NRF52BOOT/

clean:
	rm -rf ./build