import re
import subprocess

def mark(text, args, Mark, extra_cli_args, *a):
    # This function is responsible for finding all
    # matching text. extra_cli_args are any extra arguments
    # passed on the command line when invoking the kitten.
    # We mark all individual device codes for potential selection
    for idx, m in enumerate(re.finditer(r'\b([A-Z0-9]{4}-[A-Z0-9]{4})(\b)', text)):
        start, end = m.span()
        mark_text = text[start:end].replace('\n', '').replace('\0', '')
        # Find the device flow URL from the screen text
        url_match = re.search(r'https?://[^\s]+/login/device', text)
        url = url_match.group(0) if url_match else 'https://github.com/login/device'
        yield Mark(idx, start, end, mark_text, {'url': url})


def handle_result(args, data, target_window_id, boss, extra_cli_args, *a):
    # This function is responsible for performing some
    # action on the selected text.
    # matches is a list of the selected entries and groupdicts contains
    # the arbitrary data associated with each entry in mark() above
    matches, groupdicts = [], []
    for m, g in zip(data['match'], data['groupdicts']):
        if m:
            matches.append(m), groupdicts.append(g)

    for word, match_data in zip(matches, groupdicts):
        # Copy the word to the clipboard by shelling out to pbcopy
        subprocess.run("pbcopy", text=True, input=word)
        # Open the device flow URL found on screen with skip_account_picker
        url = match_data.get('url', 'https://github.com/login/device')
        separator = '&' if '?' in url else '?'
        boss.open_url(f'{url}{separator}skip_account_picker=true')
