class ApiEndpoints {
  static final String postRegister = "auth/login/".apexBaseUrl;
  static final String postLogin = "auth/login/".apexBaseUrl;
  static final String getBatches = "auth/batches/".apexBaseUrl;
  static final String getDailyTasks = "tasks/dailyTasks/".apexBaseUrl;
  static final String postIncrementTask = "tasks/repsInc/".apexBaseUrl;
  static final String postSetTaskScore = "tasks/postSetTaskScore/".apexBaseUrl; // todo
  static final String postResetTask = "tasks/repsReset/".apexBaseUrl;
  static final String getTasksRecord = "tasks/getTaskRecord/".apexBaseUrl;
  static final String getProfile = "profile/getProfile/".apexBaseUrl;
  static final String postUpdateProfile = "profile/updateProfile/".apexBaseUrl;
  static final String getLevels = "rh/getLevels/".apexBaseUrl;
  static final String getLevelDetails = "rh/getLevelDetails/".apexBaseUrl;
  static final String postSubmitExam = "exams/postSubmitExam/".apexBaseUrl;
  static final String getExamsAndScores = "exams/getExamsAndScores/".apexBaseUrl;
  static final String getExamDetails = "exams/getExamDetails/".apexBaseUrl;
  static final String getWeeklyTask = "tasks/weeklyTasks/".apexBaseUrl;
  static final String postWeekAssesment = "calls/postWeekAssesment/".apexBaseUrl;
  static final String postOralAssesment = "calls/postOralAssesment/".apexBaseUrl;

    static final String surah = "surah".quraanBaseUrl;

  static final String getPoints = "points/getPoints/".apexBaseUrl;
  static final String postEarnPoints = "points/postEarnPoints/".apexBaseUrl;
  static final String postConsumePoints = "points/postConsumePoints".apexBaseUrl;

}

extension on String {
  String get apexBaseUrl => "https://apex.oracle.com/pls/apex/simplex/$this";

  String get quraanBaseUrl => "http://api.alquran.cloud/v1/$this";
}
