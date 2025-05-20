import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_providers.dart';
import '../screens/cart_screen.dart';
import '../screens/products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductProviders())],
      child: MaterialApp(
        title: 'Catalogo de productos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal, // CAMBIA ESTE COLOR
          ),
          useMaterial3: true,
        ),
        home: EcommerceCatalog(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// *Pantalla principal con pestañas (catálogo y carrito)

// *Utiliza [DefaultTabController] para manejar dos pestañas:
// * - Productos: muestra la lista de productos disponibles.
// * - Carrito: muestra los productos agregados al carrito.
// * El AppBar incluye un contador de productos en el carrito y permite navegar entre pestañas.
class EcommerceCatalog extends StatelessWidget {
  const EcommerceCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: Text("Café Ko'o", style: TextStyle(color: Colors.white)),
        actions: [
          // *Icono de carrito con contador de productos
          Consumer<ProductProviders>(
            builder: (context, provider, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () {
                      // *Navegar a pantalla separada del carrito
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CartScreen()),
                      );
                    },
                  ),
                  if (provider.cartProducts.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${provider.cartProducts.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: ProductsScreen(), // ya no hay TabBarView
    );
  }
}
