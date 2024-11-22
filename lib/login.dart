import 'package:bibimysalon_klmpk6/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homelog.dart'; // Pastikan file ini sudah benar
import 'signup.dart'; // Tambahkan ini jika Anda sudah memiliki halaman SignUp

class SalonLoginPage extends StatefulWidget {
  const SalonLoginPage({super.key});

  @override
  State<SalonLoginPage> createState() => _SalonLoginPageState();
}

class _SalonLoginPageState extends State<SalonLoginPage> {

  //untuk menyambungkan ke auth
  final _auth = AuthService();

  //bagian buat wadah pas dari field yang ada di tampilan
  final _email = TextEditingController();
  final _password = TextEditingController();

  //untuk mengurangi memori dari setiap pengambilan text controller
  @override
  void dispose(){
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEAE3), // Background color
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container untuk memberikan jeda di atas logo
            Container(
              height: 80, // Atur tinggi sesuai kebutuhan
              color: Color(0xFF121481), // Warna jeda
            ),

            // Logo Container
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "img/logo.jpg", // Ganti dengan path logo salon
                height: 100,
              ),
            ),

            // Garis Melengkung (Curved Divider)
            Container(
              padding: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              child: ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  height: 40,
                  color: Color(0xFF121481),
                ),
              ),
            ),

            // Title "Log In"
            Text(
              "Log In",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF121481), // Warna judul
              ),
            ),

            // Email Field
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Password Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Forget Password Link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    print("Forgot Password Clicked");
                  },
                  child: Text("Forgot Password?"),
                ),
              ),
            ),

            // Sign Up Link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigasi ke halaman SignUp
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    );
                  },
                  child: Text("Sign Up"),
                ),
              ),
            ),

            // Log In Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Panggil metode login
                      final user = await _login();

                      // Cek apakah user berhasil login
                      if (user != null) {
                        // Navigasi ke halaman Home jika kredensial benar
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeLog()), // Halaman setelah login
                        );
                      }
                    } catch (e) {
                      String errorMessage = 'An unknown error occurred';

                      // Tangkap dan cek jenis error dari FirebaseAuth
                      if (e is FirebaseAuthException) {
                        switch (e.code) {
                          case 'user-not-found':
                            errorMessage = 'No user found with this email.';
                            break;
                          case 'wrong-password':
                            errorMessage = 'Incorrect password. Please try again.';
                            break;
                          case 'invalid-email':
                            errorMessage = 'The email address is not valid.';
                            break;
                          case 'user-disabled':
                            errorMessage = 'This user account has been disabled.';
                            break;
                          default:
                            errorMessage = 'Login failed: ${e.message}';
                        }
                      } else {
                        errorMessage = 'Error: $e';
                      }

                      // Tampilkan dialog error dengan pesan spesifik
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Login Failed'),
                            content: Text(errorMessage),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Tutup dialog
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                // onPressed: () async {
                //   // Panggil metode login
                //   final user = await _login();
                //
                //   // Cek apakah user berhasil login
                //   if (user != null) {
                //     // Navigasi ke halaman Home jika kredensial benar
                //     Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(builder: (context) => const HomeLog()), // Halaman setelah login
                //     );
                //   } else {
                //     // Tampilkan dialog error jika login gagal
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: const Text('Login Failed'),
                //           content: const Text('Incorrect email or password. Please try again.'),
                //           actions: [
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.of(context).pop(); // Tutup dialog
                //               },
                //               child: const Text('OK'),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   }
                // },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    "Log In",
                    style: TextStyle(fontSize: 18, color: Colors.white), // Text color for button
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA6A6), // Menggunakan warna dari palet Anda
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    return await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
  }
}

// Custom Clipper for the curved divider
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
