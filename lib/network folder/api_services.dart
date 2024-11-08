import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_konect/network%20folder/app_exceptions.dart';

class ApiService {
  Future<dynamic> get(String url, http.Client client, String userToken) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $userToken',
      };
      http.Response response = await client.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode < 200 || response.statusCode > 299) {
        throw response.body;
      }

      return response;
    } on SocketException {
      throw FetchDataException;
    }
  }

  Future<dynamic> post(
      String url, Map payload, http.Client client, String userToken) async {
    try {
      Map<String, String> apiHeaders = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $userToken',
      };
      String body = jsonEncode(payload);
      http.Response response =
          await client.post(Uri.parse(url), headers: apiHeaders, body: body);
      if (response.statusCode < 200 ||
          response.statusCode > 299 ||
          response.statusCode == 203) {
        debugPrint(response.body.toString());
        throw response.body;
      }
      debugPrint(response.body.toString());
      return response;
    } on SocketException {
      throw FetchDataException;
    }
  }

  Future<dynamic> delete(
      String url, Map payload, http.Client client, String userToken) async {
    try {
      Map<String, String> apiHeaders = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $userToken',
      };
      String body = jsonEncode(payload);
      http.Response response =
          await client.delete(Uri.parse(url), body: body, headers: apiHeaders);
      if (response.statusCode < 200 || response.statusCode > 299) {
        throw response.body;
      }

      return response;
    } on SocketException {
      throw FetchDataException;
    }
  }

  Future<dynamic> patch(
      String url, Map payload, http.Client client, String userToken) async {
    try {
      Map<String, String> apiHeaders = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $userToken',
      };
      String body = jsonEncode(payload);
      http.Response response =
          await client.patch(Uri.parse(url), headers: apiHeaders, body: body);
      if (response.statusCode < 200 || response.statusCode > 299) {
        throw response.body;
      }

      return response;
    } on SocketException {
      throw FetchDataException;
    }
  }

  Future<dynamic> put(
      String url, Map payload, http.Client client, String userToken) async {
    try {
      Map<String, String> apiHeaders = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $userToken',
      };
      String body = jsonEncode(payload);
      http.Response response =
          await client.put(Uri.parse(url), headers: apiHeaders, body: body);
      if (response.statusCode < 200 || response.statusCode > 299) {
        throw response.body;
      }

      return response;
    } on SocketException {
      throw FetchDataException;
    }
  }
}
