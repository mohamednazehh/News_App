import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemeabdallahmansor/layout/news_app/cubit/cubit.dart';
import 'package:udemeabdallahmansor/layout/news_app/cubit/states.dart';
import 'package:udemeabdallahmansor/shared/componants/componants.dart';

class SearchScreen extends StatelessWidget
{

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,states){},
      builder: (context,states)
      {
        var list = NewsCubit.get(context).search;

        return  Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                  onChanged: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context))
            ],
          ),
        );
      },
    );
  }
}
