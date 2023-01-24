import 'package:flutter/material.dart';
import 'package:flutter_nusantara/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_nusantara/widgets/button_custom.dart';
import 'package:flutter_nusantara/widgets/formfield_custom.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddbookScreen extends StatefulWidget {
  const AddbookScreen({super.key});

  @override
  State<AddbookScreen> createState() => _AddbookScreenState();
}

class _AddbookScreenState extends State<AddbookScreen> {
  late HomeViewModel vm;
  // "isbn": isbn,
  //           "title": title,
  //           "subtitle": subtitle,
  //           "author": author,
  //           "published": published,
  //           "publisher": publisher,
  //           "pages": pages,
  //           "description": description,
  //           "website": website,
  final _formKey = GlobalKey<FormState>();

  final _isbn = TextEditingController();
  final _title = TextEditingController();
  final _subtitle = TextEditingController();
  final _author = TextEditingController();
  final _published = TextEditingController();
  final _publisher = TextEditingController();
  final _pages = TextEditingController();
  final _description = TextEditingController();
  final _website = TextEditingController();

  void addbook(context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    vm.addBook(
      context,
      _isbn.text,
      _title.text,
      _subtitle.text,
      _author.text,
      _published.text,
      _publisher.text,
      _pages.text,
      _description.text,
      _website.text,
    );
  }

  Future _selectDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (date == null) {
      _published.text = '';
      return;
    }
    _published.text = DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  void initState() {
    super.initState();
    vm = Provider.of<HomeViewModel>(context, listen: false);

    /// Run method on Widget build complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // FocusScope.of(context).requestFocus(_initialFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Add Book',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextFormCustom(
                          keyboardType: TextInputType.number,
                          controller: _isbn,
                          hintText: 'Isbn',
                          validator: (value) {
                            if (value == null) {
                              return 'Tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextFormCustom(
                          controller: _title,
                          hintText: 'Title',
                          validator: (value) {
                            if (value == '') {
                              return 'Tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextFormCustom(
                          controller: _subtitle,
                          hintText: 'Subtitle',
                          validator: (value) {
                            if (value == '') {
                              return 'Tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextFormCustom(
                          controller: _author,
                          hintText: 'Author',
                          validator: (value) {
                            if (value == '') {
                              return 'Tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextFormCustom(
                          onTap: (() => _selectDate()),
                          controller: _published,
                          hintText: 'Published',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silahkan pilih tanggal';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextFormCustom(
                          controller: _publisher,
                          hintText: 'Publisher',
                          validator: (value) {
                            if (value == '') {
                              return 'Tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextFormCustom(
                          keyboardType: TextInputType.number,
                          controller: _pages,
                          hintText: 'Pages',
                          validator: (value) {
                            if (value == '') {
                              return 'Tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextFormCustom(
                          controller: _description,
                          hintText: 'Description',
                          validator: (value) {
                            if (value == '') {
                              return 'Tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: TextFormCustom(
                          controller: _website,
                          hintText: 'Website',
                          validator: (value) {
                            if (value == '') {
                              return 'Tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      ButtonFormCustom(
                          child: const Text('Add Book'),
                          onPressed: () => addbook(context))
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
