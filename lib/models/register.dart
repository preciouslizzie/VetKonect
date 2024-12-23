class Register {
    Register({
        required this.email,
    });

    final String? email;

    factory Register.fromJson(Map<String, dynamic> json){ 
        return Register(
            email: json["\u0024email"],
        );
    }

}
