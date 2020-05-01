import 'package:easybuy_frontend/src/pages/swiper_targe.dart';
import 'package:easybuy_frontend/src/providers/searchProvider.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
    final int idUser;

  @override

  Search(this.idUser);

  List<Widget> buildActions(BuildContext context) {
    // acciones de nuestro Appbar-como iconos de limpiar o cancelar busqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias que aparecen cuando la persona escribe
    List results;
    final SearchProvider search = SearchProvider();

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: search.getResult(query).then((resp) {
        results = resp;
        return results;
      }),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: results == null ? 0 : results.length,
            itemBuilder: (context, index) => gets(context, index, results),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget gets(BuildContext context, index, results) {
    return ListTile(
      leading: FadeInImage(
        image: NetworkImage(results[index]["url1"]),
        placeholder: AssetImage('assets/no-image.png'),
        width: 50.0,
        fit: BoxFit.contain,
      ),
      title: Text(results[index]["nameProduct"]),
      onTap: () {
        close(context, null);

        final id = results[index]["idProduct"];
        print(id);
        final route = MaterialPageRoute(builder: (context) {
          return SwiperTarge(
            productId: id,
          );
        });
        Navigator.push(context, route);
      },
    );
  }
}
