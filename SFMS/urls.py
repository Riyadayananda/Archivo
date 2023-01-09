from django.urls import path
from django.conf import settings



from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("Login/", views.Login, name="Login"),
    path("StudentReg/",views.StudentReg, name="StudentReg"),
    path("TeacherReg/",views.TeacherReg, name="TeacherReg"),
    #path("404/", views.notfound, name="ERROR404"),
    path("doLogin",views.doLogin, name="doLogin"),
    path("doReg",views.doReg,name="doReg"),
    path("trial",views.trial),
    path("StudentDashboard",views.StudentDashboard,name="StudentDashboard"),
    path("TeacherDashboard",views.TeacherDashboard, name="TeacherDashboard"),
    path("StudentDashboard/StudentProfile", views.StudentProfile, name="StudentProfile"),
    path("TeacherDashboard/TeacherProfile", views.TeacherProfile, name="TeacherProfile"),
    path("StudentDashboard/archive", views.archive, name="archive"),
    path("StudentDashboard/<SubjectCode>", views.StudentFilePage, name="StudentFilePage"),
    path("TeacherDashboard/<ClassName>", views.TeacherFilePage, name="TeacherFilePage"),
    path("downloadFile", views.downloadFile, name="downloadFile"),
    path("deleteFile",views.deleteFile, name="deleteFile"),
]

