/*
 * @Author GS
 */
import 'package:payment_gateway/utils/enviornment_util.dart';

class FirebasePath {
  static String userData(String uid) =>
      '${EnvironmentUtil.prefix}/users/$uid/user_data';
  static String userExpertiseList(String uid) =>
      '${EnvironmentUtil.prefix}/users/$uid/expertise_list';
  static String coursesSubjectsList() =>
      '${EnvironmentUtil.prefix}/app_data/courses_list';
  static String feeds(String id, String subjectId) =>
      '${EnvironmentUtil.prefix}/feeds/$subjectId/$id';
  static String feedsList() => '${EnvironmentUtil.prefix}/feeds';
  static String userFeeds(String id, String uid) =>
      '${EnvironmentUtil.prefix}/users/$uid/feeds/$id';
  static String courseData(String id) => '${EnvironmentUtil.prefix}/course/$id';
  static String courseDataAddVideo(
          String courseId, int contentId, int videoId) =>
      '${EnvironmentUtil.prefix}/course/$courseId/contents/$contentId/videos/$videoId';
  static String courseDataRemoveVideo(
          String courseId, int contentId, int videoId) =>
      '${EnvironmentUtil.prefix}/course/$courseId/contents/$contentId/videos';
  static String courseDataAddImage(
          String courseId, int contentId, int imageId, int videoId) =>
      '${EnvironmentUtil.prefix}/course/$courseId/contents/$contentId/videos/$videoId/images/$imageId';
  static String courseDataRemoveImage(
          String courseId, int contentId, int imageId, int videoId) =>
      '${EnvironmentUtil.prefix}/course/$courseId/contents/$contentId/videos/$videoId/images';
  static String courseDataAddLink(
          String courseId, int contentId, int linkId, int videoId) =>
      '${EnvironmentUtil.prefix}/course/$courseId/contents/$contentId/videos/$videoId/links/$linkId';
  static String courseDataRemoveLink(
          String courseId, int contentId, int linkId, int videoId) =>
      '${EnvironmentUtil.prefix}/course/$courseId/contents/$contentId/videos/$videoId/links';
  static String courseDataArrangeVideo(String courseId, int contentId) =>
      '${EnvironmentUtil.prefix}/course/$courseId/contents/$contentId/videos';
  static String courseDataArrangeImage(String courseId, int contentId) =>
      '${EnvironmentUtil.prefix}/course/$courseId/contents/$contentId/images';
  static String courseDataArrangeLink(String courseId, int contentId) =>
      '${EnvironmentUtil.prefix}/course/$courseId/contents/$contentId/links';
  static String courseUserRef(String uid, String id) =>
      '${EnvironmentUtil.prefix}/users/$uid/courses/$id';
  static String coursesUserList(String uid) =>
      '${EnvironmentUtil.prefix}/users/$uid/courses';
  static String purchasedCoursesUserList(String uid) =>
      '${EnvironmentUtil.prefix}/users/$uid/purchasedCourses';
  static String adminCoursesList() => '${EnvironmentUtil.prefix}/course';

  static String coursesListInSubject(String courseId, int board, int cls) =>
      '${EnvironmentUtil.prefix}/courses_list/$board/$cls/$courseId';
}
