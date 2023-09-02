import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/cart/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_sources/local/cart_local_data_source.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/cart_remote_data_source.dart';
import '../models/cart/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  CartRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> addToCart(CartItem params) async {
    if (await userLocalDataSource.isTokenAvailable()) {
      // final remoteProducts = await remoteDataSource.addToCArt;
      return Left(CacheFailure());
    } else {
      final localProducts =
          await localDataSource.cacheCartItem(CartItemModel.fromParent(params));
      return Right(localProducts);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFormCart() {
    // TODO: implement deleteFormCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCachedCart() async {
    final localProducts = await localDataSource.getCart();
    return Right(localProducts);
  }

  @override
  Future<Either<Failure, List<CartItem>>> getRemoteCart() {
    // TODO: implement getRemoteCart
    throw UnimplementedError();
  }
}
