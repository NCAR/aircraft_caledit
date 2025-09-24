# aircraft_caledit
EOL/RAF aircraft calibration editor

The calibration editor has a few functions.  
 1) sweep calibrations off the aircraft alibrations database and into a database inhouse (moved to rosetta DEC 1, 2023).
 2) view calibrations and export them to nidas cal files.
 3) calibrations can be duplicated and then edited if need before exporting.  Original cals from the aircraft can not be edited (paper trail).
 
## Usage and approval process

**When in doubt, right click**
* The view menu allows you to change which rows/columns are displayed.
* Right clicking on a row provides a dropdown with actions.

The calibration process is as follows:

* Technicians will perform the calibrations using Calibration Flight mode and will generate plots showing that past and current cals agree.
* Technicians will email plots to rafsehelp@eol.ucar.edu, appropriate RSIG and PM staff for review
 * caledit can be used to review the ADS cals for approval if more information is required than is contained in the emailed plots.
 * A print screen from aeros can also be a useful review tool.
* SEs will sweep the cals from the aircraft into the calibrations database
 * The aircraft you want to sweep must be powered up and online.
 * Run caledit as user ads on eol-rosetta
   * To confirm cals are in the database: "psql -h eol-rosetta -U ads -d calibrations" and "select * from calibrations where project_name='<PROJECT>';
   * Changes will be backed up to /net/jlocal/projects/Configuration/cal_files/master-calibrations.sql
     * Either wait for /net/jlocal/projects/scripts/backupCalib.cron to run from ads cron on eol-rosetta on Monday at 5am, or you can run it manually now.
     * Commit changes to github.


 * Select cals you want to export to a nidas cal file
   * ADIFR, BDIFR, QCF, QCR, QCFR are all serial pressure sensors. Cals are only done to ensure they aren't malfuctioning - nothing to export
   * Right click the line in caledit and click "Export to Cal File"
   * git commit/push projects/Configuration/cal_files
   * git pull projects on plane to pull new cals

There is a Wiki with more info https://wiki.ucar.edu/spaces/SEW/pages/364844232/CalDatabaseBackupSpecs
