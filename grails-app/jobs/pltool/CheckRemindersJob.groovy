package pltool

import net.pragmalab.pltool.HomeController

class CheckRemindersJob {

    def myHome = new HomeController()

    static triggers = {
        cron name: 'myTrigger', cronExpression: "0 * * ? * *"
        cron name: 'myTrigger2', cronExpression: "30 * * ? * *"
    }

    def execute() {

        myHome.checkReminders();

    }
}
