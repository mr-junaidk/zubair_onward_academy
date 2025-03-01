import 'package:zubair_onward_academy/data/network/network_api_services.dart';
import 'package:zubair_onward_academy/data/network/base_api_services.dart';
import 'package:zubair_onward_academy/models/lectures_model.dart';
import 'package:zubair_onward_academy/models/mcqs_model.dart';
import 'package:zubair_onward_academy/models/notes_model.dart';
import 'package:zubair_onward_academy/viewmodel/auth_view_model.dart';
import 'package:zubair_onward_academy/models/category_model.dart';
import 'package:zubair_onward_academy/models/books_model.dart';
import 'package:zubair_onward_academy/res/app_url.dart';
import 'package:flutter/cupertino.dart';


class AuthRepository{
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginApiEndPoint, data);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.signupApiEndPoint, data);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<BooksResponse> fetchBooks(String categoryId, BuildContext context) async {
    try {
      String? token = await getToken(context);

      if (token == null || token.isEmpty) {
        throw Exception('Token not found or invalid');
      }

      // Construct the URL
      String url = '${AppUrl.booksApiEndPoint}/$categoryId';

      // Make the API request with the token in the headers
      dynamic response = await _apiServices.getGetApiResponse(
        url,
        headers: {
          "token": token,
        },
      );

      // Parse and return the response
      return BooksResponse.fromJson(response);

    } catch (e) {
      throw e;

    }
  }

  Future<NotesResponse> fetchNotes(String categoryId, BuildContext context) async {
    try {
      String? token = await getToken(context);

      if (token == null || token.isEmpty) {
        throw Exception('Token not found or invalid');
      }

      // Construct the URL
      String url = '${AppUrl.notesApiEndPoint}/$categoryId';

      // Make the API request with the token in the headers
      dynamic response = await _apiServices.getGetApiResponse(
        url,
        headers: {
          "token": token,
        },
      );

      // Parse and return the response
      return NotesResponse.fromJson(response);

    } catch (e) {
      throw e;

    }
  }

  Future<LecturesResponse> fetchLectures(String categoryId, BuildContext context) async {
    try {
      String? token = await getToken(context);

      if (token == null || token.isEmpty) {
        throw Exception('Token not found or invalid');
      }

      // Construct the URL
      String url = '${AppUrl.lecturesApiEndPoint}/$categoryId';

      // Make the API request with the token in the headers
      dynamic response = await _apiServices.getGetApiResponse(
        url,
        headers: {
          "token": token,
        },
      );

      // Parse and return the response
      return LecturesResponse.fromJson(response);

    } catch (e) {
      throw e;

    }
  }

  Future<McqsResponse> fetchMcqs(String categoryId, BuildContext context) async {
    try {
      String? token = await getToken(context);

      if (token == null || token.isEmpty) {
        throw Exception('Token not found or invalid');
      }

      // Construct the URL
      String url = '${AppUrl.mcqsApiEndPoint}/$categoryId';

      // Make the API request with the token in the headers
      dynamic response = await _apiServices.getGetApiResponse(
        url,
        headers: {
          "token": token,
        },
      );

      // Parse and return the response
      return McqsResponse.fromJson(response);

    } catch (e) {
      throw e;

    }
  }


  Future<CategoryResponse> fetchCategories() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(AppUrl.categoryApiEndPoint, headers: {});
      return CategoryResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}