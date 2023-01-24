import 'package:flutter/material.dart';
import 'package:flutter_nusantara/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_nusantara/features/splash/viewmodel/splash_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late HomeViewModel vm;

  @override
  void initState() {
    vm = Provider.of<HomeViewModel>(context, listen: false);
    vm.getBooks(context);
    super.initState();
  }

  void logout(context) {
    vm.logout(context);
    _scaffoldKey.currentState!.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(context.read<SplashViewModel>().username),
            ),
            ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Logout'),
                onTap: () => logout(context)),
          ],
        )),
        appBar: AppBar(
          title: const Text('Books List'),
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
        ),
        body: Consumer<HomeViewModel>(builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.data.isEmpty) {
            return const Center(child: Text('No data'));
          }
          return ListView.builder(
              itemCount: vm.data.length,
              itemBuilder: (context, index) {
                final data = vm.data[index];
                return ListTile(
                  title: Text(data.title!),
                  subtitle: Text(data.subtitle!),
                  onTap: () {
                    Navigator.pushNamed(context, '/detailbook',
                        arguments: data);
                  },
                );
              });
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addbook');
          },
          child: const Icon(Icons.add),
        ));
  }
}
