// import 'package:BusGo/data/models/products/product_model.dart';
// import 'package:BusGo/data/repository/products_repository.dart';
// import 'package:BusGo/data/services/globalCallApi/apiService.dart';
// import 'package:BusGo/domain/blocs/products_bloc/products_signal.dart';

// // Repositorio de configuración (se asume que ya está inicializado en otro lugar)
// final ProductsRepository productsRepository = ProductsRepository(authService: ApiService());

// // Método para cargar productos
// Future<void> loadProduct(int homeId, int warehouseId) async {
//   isLoadingSignalPR.value = true;
//   productErrorSignal.value = null;
//   productEmpySignal.value = null;

//   try {
//     final result = await productsRepository.getProduct(homeId, warehouseId);

//     if (result is String) {
//       //está vacio
//       productEmpySignal.value = result;
//     } else if (result is Product) {
//       //hay producto
//       productSignal.value = result;
//       print('resultado al devolver los producto-$result');
//     }
//   } catch (error) {
//     productErrorSignal.value = error.toString();
//   } finally {
//     isLoadingSignalPR.value = false;
//   }
// }

// // Métodos para actualizar datos del producto
// void updateProductData(ProductElement updatedElement) {

//   if (productElementSignal.value == null) {
//     // Si es null, asigna el valor directamente
//     productElementSignal.value = updatedElement;
//   } else {
//     // Usa copyWith para actualizar solo los campos necesarios
//     productElementSignal.value = productElementSignal.value!.copyWith(      
//       productId: updatedElement.productId ?? productElementSignal.value!.productId,
//       id: updatedElement.id ?? productElementSignal.value!.id,
//       warehouseId: updatedElement.warehouseId ?? productElementSignal.value!.warehouseId,
//       productName: updatedElement.productName ?? productElementSignal.value!.productName,
//       additionalNotes: updatedElement.additionalNotes ?? productElementSignal.value!.additionalNotes,
//       categoryId: updatedElement.categoryId ?? productElementSignal.value!.categoryId,
//       statusId: updatedElement.statusId ?? productElementSignal.value!.statusId,
//       unitPrice: updatedElement.unitPrice ?? productElementSignal.value!.unitPrice,
//       purchaseDate: updatedElement.purchaseDate ?? productElementSignal.value!.purchaseDate,
//       expirationDate: updatedElement.expirationDate ?? productElementSignal.value!.expirationDate,
//       purchasePlace: updatedElement.purchasePlace ?? productElementSignal.value!.purchasePlace,
//       brand: updatedElement.brand ?? productElementSignal.value!.brand,
//       count: updatedElement.count ?? productElementSignal.value!.count,
//       quantity: updatedElement.quantity ?? productElementSignal.value!.quantity,
//       image: updatedElement.image ?? productElementSignal.value!.image,
//     );
//   }
// }
// getPrice()
// {
//   return productElementSignal.value!.unitPrice;
// }


// // Métodos para aumentar o disminuir la cantidad
// void increaseQuantity() {
//   quantitySignal.value += 1;
// }

// void decreaseQuantity() {
//   if (quantitySignal.value > 1) {
//     quantitySignal.value -= 1;
//   }
// }


// void updateQuantity(int quantity) {
//   if (quantity > 0) {
//     quantitySignal.value = quantity;
//   }
//   else{
//     quantitySignal.value = 1;
//   }
// }


// // Método para enviar el producto a la API
// Future<void> submitProduct() async {
//   isProductSubmittingSignal.value = true;
//   submitErrorSignal.value = "";

//   try {
//     await productsRepository.addProduct(productElementSignal.value!);
//     productSubmittedSuccessSignal.value = true;
//   } catch (error) {
//     submitErrorSignal.value = error.toString();
//     productSubmittedSuccessSignal.value = false;
//   } finally {
//     isProductSubmittingSignal.value = false;
//   }
// }

// // Método para enviar el producto a la API
// Future<void> updateProduct() async {
//   isProductSubmittingSignal.value = true;
//   submitErrorSignal.value = "";

//   try {
//     await productsRepository.updateProductRepository(productElementSignal.value!);
//     productSubmittedSuccessSignal.value = true;
//   } catch (error) {
//     submitErrorSignal.value = error.toString();
//     productSubmittedSuccessSignal.value = false;
//   } finally {
//     isProductSubmittingSignal.value = false;
//   }
// }

// // Método para enviar el producto a la API
// Future<void> deleteProduct(int id) async {
//   isProductSubmittingSignal.value = true;
//   submitErrorSignal.value = "";

//   try {
//     await productsRepository.deleteProduct(id);
//     productSubmittedSuccessSignal.value = true;
//   } catch (error) {
//     submitErrorSignal.value = error.toString();
//     productSubmittedSuccessSignal.value = false;
//   } finally {
//     isProductSubmittingSignal.value = false;
//   }
// }

// void clearProductSignals() {
//   // Restablecer las señales a sus valores predeterminados
//   productSignal.value = null;
//   productElementSignal.value = const ProductElement();
//   quantitySignal.value = 1;

//   isLoadingSignalPR.value = false;
//   productErrorSignal.value = null;
//   productEmpySignal.value = null;
//   submitErrorSignal.value = "";

//   isProductSubmittingSignal.value = false;
//   productSubmittedSuccessSignal.value = false;
// }
