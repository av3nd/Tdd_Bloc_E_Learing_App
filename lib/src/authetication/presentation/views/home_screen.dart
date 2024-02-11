import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial_flutter/src/authetication/presentation/cubit/authentication_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if(state is AuthenticatonError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)),);
        }
        else if(state is UserCreated){
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers ? const Center(
            child: CircularProgressIndicator(),
          )
          : Center(
            child: ListView.builder(itemBuilder: itemBuilder),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddUserDialog(),
              );
            },
            icon: const Icon(Icons.add),
            label: Text("Add User"),
          ),
        );
      },
    );
  }
}
