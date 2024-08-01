#!/bin/sh

# Путь к файлу яркости
BRIGHTNESS_PATH="/sys/class/backlight/amdgpu_bl1"

# Увеличить яркость
increase_brightness() {
    max_brightness=$(cat "$BRIGHTNESS_PATH/max_brightness")
    current_brightness=$(cat "$BRIGHTNESS_PATH/brightness")
    new_brightness=$((current_brightness + max_brightness / 10))
    if [ $new_brightness -gt $max_brightness ]; then
        new_brightness=$max_brightness
    fi
    echo $new_brightness | sudo tee "$BRIGHTNESS_PATH/brightness" > /dev/null
}

# Уменьшить яркость
decrease_brightness() {
    max_brightness=$(cat "$BRIGHTNESS_PATH/max_brightness")
    current_brightness=$(cat "$BRIGHTNESS_PATH/brightness")
    new_brightness=$((current_brightness - max_brightness / 10))
    if [ $new_brightness -lt 0 ]; then
        new_brightness=0
    fi
    echo $new_brightness | sudo tee "$BRIGHTNESS_PATH/brightness" > /dev/null
}

# Проверка аргументов командной строки
case "$1" in
    --up)
        increase_brightness
        ;;
    --down)
        decrease_brightness
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac