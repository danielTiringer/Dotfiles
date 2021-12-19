#!/usr/bin/env python3

from getpass import getpass
import json
import re
import subprocess

class Dialogue:
    def prompt_option_selection(self, options):
        print('Please select what you want to do:')
        self.print_menu(options)
        option = ''
        try:
            option = int(input('Enter your choice: '))
        except:
            print('Wrong input. Please enter a number...')

        return option

    def confirm_choice(self, choice_string):
        print(choice_string)
        while True:
            confirm = input('[y]Yes or [n]No: ')
            if confirm in ('y', 'n'):
                return confirm
            else:
                print('Invalid Option. Please Enter a Valid Option.')

    def print_menu(self, list):
        for key in list.keys():
            print(key, '--', list[key])

class Bitwarden:
    main_menu_options = {
        1: 'Create new item',
        2: 'Create new folder',
        3: 'Cancel',
    }
    item_types = {
        1: 'Login',
        2: 'Secure Note',
        3: 'Card',
        4: 'Identity',
        5: 'Cancel',
    }
    session_key = ''
    folders = []

    def __init__(self, dialogue: Dialogue):
        self.dialogue = dialogue
        self.check_bitwarden_login()
        self.unlock_vault()
        self.sync_vault()

    def process_request(self):
        while(True):
            option = self.dialogue.prompt_option_selection(self.main_menu_options)

            if option == 1:
                self.process_new_item_request()

            if option == 2:
                self.process_new_folder_request()

            if option == 3:
                print('User aborted.')
                exit(0)

    def check_bitwarden_login(self):
        status_string = subprocess.getoutput('bw status')
        status_json = json.loads(status_string)
        if status_json['status'] == 'unauthenticated':
            print('You are not logged into Bitwarden. Please use the "bw login" command to log in and try again.')
            exit(1)

    def unlock_vault(self):
        password = self.get_users_password()
        status = subprocess.getoutput(f"echo {password} | bw unlock")
        substring = re.search(r'"([A-Za-z0-9/+=]*)=="', status)
        self.session_key = substring.group()

    def get_users_password(self):
        return getpass('Please enter your Bitwarden password: ')

    def sync_vault(self):
        status = subprocess.getstatusoutput(f"bw sync --session {self.session_key}")
        if status[0] != 0:
            print('Unable to sync the vault. Please try again later.')
            exit(1)

    def process_new_item_request(self):
        while(True):
            option = self.dialogue.prompt_option_selection(self.item_types)
            if option == 5:
                print('User aborted.')
                exit(0)

    def process_new_folder_request(self):
        option = input('Enter the name of the new folder: ')
        if self.dialogue.confirm_choice(f"Are you sure you want to create a folder named {option}?") != 'y':
            print('User aborted.')
            exit(1)

        template_json = subprocess.getoutput(f"bw get template folder --session {self.session_key}")
        template = json.loads(template_json)
        template['name'] = option
        updated_template_json = json.dumps(template, separators=(',', ':'))
        output = subprocess.getstatusoutput(f"echo '{updated_template_json}' | bw encode | bw create folder --session {self.session_key}")

        if output[0] == 0:
            print("The folder was created.")
        else:
            print("There was a problem creating the folder.")

        exit(output[0])

    def get_folders(self):
        folders_string = subprocess.getoutput(f"bw list folders --session {self.session_key}")
        folders_json = json.loads(folders_string)
        folders = [a_dict['name'] for a_dict in folders_json]
        self.folders = folders


def main():
    dialogue = Dialogue()
    bitwarden = Bitwarden(dialogue)
    bitwarden.process_request()


if __name__ == '__main__':
    main()


