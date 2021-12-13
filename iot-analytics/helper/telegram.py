import telebot
import time
import sys

## configuration of telebot
TOKEN = sys.argv[1]
#tb = telebot.TeleBot(token=TOKEN, num_threads=10)
#chat = '357130715'

tb = telebot.TeleBot(token=TOKEN, num_threads=1)

tb.set_my_commands([ telebot.types.BotCommand('register','registration command')])

@tb.message_handler(commands=['register'])
def transfer_command(message):
	print(message)

@tb.message_handler(content_types=['text'])
def print_message(message):
	print(message.chat)

tb.polling()
