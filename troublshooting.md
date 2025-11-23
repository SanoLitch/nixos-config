### Troubleshooting

## K380 for mac keyboard issues

Connect via terminal

```bash
bluetoothctl
> remove F4:73:35:AB:FD:A4          # Удаляем старое подключение
> scan on                           # Ищем устройство
> trust F4:73:35:AB:FD:A4           # Доверяем устройству
> pair F4:73:35:AB:FD:A4            # Спариваем
> connect F4:73:35:AB:FD:A4         # Подключаемся к HID
> quit
```
