# ICBC Appointment Checker

This script checks for available road test appointments at various ICBC locations and sends email notifications if there are any changes.

## Features

- Checks for available road test appointments at specified ICBC locations.
- Sends email notifications if there are any changes in the available appointments.
- Saves the latest appointments to a text file.

## Requirements

- Python 3.x
- `requests`
- `pyyaml`
- `loguru`
- `faker`

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/evenevan/icbc-appointment-checker.git
   cd icbc-appointment-checker
   ```
2. Install the required Python libraries:

   ```bash
   pip install requests pyyaml loguru faker
   ```

## Configuration

1. Create a `config.yml` file in the project directory. You can use the provided `config.yml.example` as a template:

   ```bash
   cp config.yml.example config.yml
   ```
2. Edit the `config.yml` file with your own details:

   ```yaml
   icbc:
     drvrLastName: "YourLastName"
     licenceNumber: "YourLicenceNumber"
     keyword: "YourKeyword"
     examDate: "The earliest date you can take the exam as YYYY-MM-DD. Delete this field if you are past the earliest date."
     earliestDate: "2024-05-01"
     latestDate: "2024-06-01"
     earliestTime: "08:00"
     latestTime: "17:00"
     examClass: "5"
     posID: "8"
     prfDaysOfWeek: "[0,1,2,3,4,5,6]"
     prfPartsOfDay: "[0,1]"

   email:
     smtp_server: "smtp.your-email-provider.com"
     smtp_port: 587
     sender_address: "your_email@provider.com"
     sender_pass: "your_password"
     receiver_addresses:
       - "receiver1_email@provider.com"
       - "receiver2_email@provider.com"
   ```

## Usage

### Docker

To run with Docker, you can use the `Dockerfile` and/or the `docker-compose.yml`.

#### Env

| Name          | Description                                 | Default                |
| ------------- | ------------------------------------------- | ---------------------- |
| CRON_SCHEDULE | Follows https://en.wikipedia.org/wiki/Cron | 0 * * * * (every hour) |
| TZ            | Set the timezone for accurate crons         |                        |

#### Mounts

These mount files direclty, you may have issues where Docker creates and mounts config.yml and appointments.txt as folders on the host. If you encounter this, manually create these folders on the host yourself.

| Path (in container)    | Purpose                                                                      |
| ---------------------- | ---------------------------------------------------------------------------- |
| /app/config.yml        | Exposes the config to the host; the config.yml file is not part of the image |
| /root/appointments.txt | Stores the latest appointment info for comparison                            |

### Direct

Run the script with the specified config file:

```bash
bash python icbc_appointment_checker.py config.yml
```

Scheduling with Crontab

To schedule the script to run at regular intervals, you can use `crontab`. Here’s how to set it up:

1. Open the crontab editor:

   ```bash
   crontab -e
   ```
2. Add a new line to schedule the script. For example, to run the script every hour, add:

   ```bash
   0 * * * * /usr/bin/python3 /path/to/icbc_appointment_checker.py /path/to/config.yml
   ```

   Replace `/usr/bin/python3` with the path to your Python 3 executable, and `/path/to/icbc_appointment_checker.py` and `/path/to/config.yml` with the correct paths to the script and configuration file.
3. Save and exit the editor.

The script will now run every hour and check for available ICBC appointments and send email notifications to the specified recipients if there are any changes.

## Location Parameters

| Location                                              | posID |
| ----------------------------------------------------- | ----- |
| Richmond claim centre (Elmbridge Way)                 | 273   |
| Richmond driver licensing (Lansdowne Centre mall)     | 93    |
| Vancouver driver licensing (Point Grey)               | 9     |
| Vancouver claim centre (Kingsway)                     | 275   |
| Burnaby claim centre (Wayburne Drive)                 | 274   |
| Surrey driver licensing                               | 11    |
| Newton claim centre (68 Avenue)                       | 271   |
| Surrey claim centre (152A St.)                        | 269   |
| North Vancouver driver licensing                      | 8     |
| Langley driver licensing (Willowbrook Center)         | 153   |
| Port Coquitlam driver licensing                       | 73    |
| Guildford Boardwalk road test centre (Boardwalk mall) | 281   |
| Burnaby driver licensing                              | 2     |

## Changelog

See the full changelog in [CHANGELOG.md](./CHANGELOG.md).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
