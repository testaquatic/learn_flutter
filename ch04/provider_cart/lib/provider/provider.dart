import 'package:provider/provider.dart';
import 'package:provider_cart/model/models.dart';

/// 상품 저장소 프로바이더
final productRepositoryProvider = Provider(create: (_) => ProductRepository());

/// 장바구니 모델 프로바이더
final cartModelProvider = ChangeNotifierProvider(
  create: (context) => CartModel(),
);
