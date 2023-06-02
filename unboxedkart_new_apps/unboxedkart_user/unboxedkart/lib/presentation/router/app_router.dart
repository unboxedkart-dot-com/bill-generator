import 'package:flutter/material.dart';
import 'package:unboxedkart/presentation/models/question_and_answers/question_and_answers_tile.dart';
import 'package:unboxedkart/presentation/pages/about/about_pay_at_store.dart';
import 'package:unboxedkart/presentation/pages/about/about_unboxedkart.dart';
import 'package:unboxedkart/presentation/pages/addresses/addresses.dart';
import 'package:unboxedkart/presentation/pages/addresses/create_address.dart';
import 'package:unboxedkart/presentation/pages/addresses/edit_address.dart';
import 'package:unboxedkart/presentation/pages/addresses/store_addresses.dart';
import 'package:unboxedkart/presentation/pages/authentication/create_user_page.dart';
import 'package:unboxedkart/presentation/pages/authentication/login_using_mobile_number.dart';
import 'package:unboxedkart/presentation/pages/authentication/signup_using_mobile_number.dart';
import 'package:unboxedkart/presentation/pages/brand_page/brand_page.dart';
import 'package:unboxedkart/presentation/pages/cart/cart.dart';
import 'package:unboxedkart/presentation/pages/category_page/category_page.dart';
import 'package:unboxedkart/presentation/pages/condition_page/condition_page.dart';
import 'package:unboxedkart/presentation/pages/coupons/coupons.dart';
import 'package:unboxedkart/presentation/pages/faq/faqs_page.dart';
import 'package:unboxedkart/presentation/pages/order_summary/apply_coupon.dart';
import 'package:unboxedkart/presentation/pages/order_summary/order_summary.dart';
import 'package:unboxedkart/presentation/pages/order_summary/payment.dart';
import 'package:unboxedkart/presentation/pages/order_summary/select_address.dart';
import 'package:unboxedkart/presentation/pages/order_summary/select_pickup_store.dart';
import 'package:unboxedkart/presentation/pages/orders/cancel-order.dart';
import 'package:unboxedkart/presentation/pages/orders/create_order.dart';
import 'package:unboxedkart/presentation/pages/orders/need-help.dart';
import 'package:unboxedkart/presentation/pages/orders/order-cancelled.dart';
import 'package:unboxedkart/presentation/pages/orders/orders_page.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_images.dart';
import 'package:unboxedkart/presentation/pages/product_tile/product_tile.dart';
import 'package:unboxedkart/presentation/pages/product_tile/select-variant.dart';
import 'package:unboxedkart/presentation/pages/products_page/products.dart';
import 'package:unboxedkart/presentation/pages/question_and_answers/add_answer.dart';
import 'package:unboxedkart/presentation/pages/question_and_answers/ask_question.dart';
import 'package:unboxedkart/presentation/pages/question_and_answers/product_q_and_a.dart';
import 'package:unboxedkart/presentation/pages/question_and_answers/question_and_answers_page.dart';
import 'package:unboxedkart/presentation/pages/refer_and_earn/coupon_referrals.dart';
import 'package:unboxedkart/presentation/pages/refer_and_earn/payment_details.dart';
import 'package:unboxedkart/presentation/pages/refer_and_earn/refer_and_earn.dart';
import 'package:unboxedkart/presentation/pages/reviews/create-review.dart';
import 'package:unboxedkart/presentation/pages/reviews/edit-review.dart';
import 'package:unboxedkart/presentation/pages/reviews/product_reviews.dart';
import 'package:unboxedkart/presentation/pages/reviews/reviews.dart';
import 'package:unboxedkart/presentation/pages/search/search_page.dart';
import 'package:unboxedkart/presentation/pages/seller_page/seller_page.dart';
import 'package:unboxedkart/presentation/pages/user_details/user_details.dart';
import 'package:unboxedkart/presentation/pages/user_main/user_main.dart';
import 'package:unboxedkart/presentation/pages/wishlist/wishlist.dart';

import '../../models/order_tile/order_tile.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final props = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        if (props is UserMain) {
          return MaterialPageRoute(
            builder: (_) => UserMain(
              index: props.index,
            ),
          );
        }
        break;
      case '/pay-at-store':
        return MaterialPageRoute(builder: (_) => const PayAtStoreDetails());
        break;
      case '/about-unboxedkart':
        return MaterialPageRoute(builder: (_) => const AboutUnboxedkart());
        break;
      case '/login':
        if (props is LoginUsingMobileNumberPageUpdated) {
          return MaterialPageRoute(
            builder: (_) => LoginUsingMobileNumberPageUpdated(
              showProfile: props.showProfile,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const LoginUsingMobileNumberPageUpdated(),
          );
        }

        break;
      case '/product-reviews':
        if (props is ProductReviewsPage) {
          return MaterialPageRoute(
              builder: (_) => ProductReviewsPage(
                    productId: props.productId,
                  ));
        }
        break;
      case '/product-q-and-a':
        if (props is ProductQandAPage) {
          return MaterialPageRoute(
              builder: (_) => ProductQandAPage(
                    productId: props.productId,
                  ));
        }
        break;
      case '/user-details':
        return MaterialPageRoute(
          builder: (_) => const UserDetails(),
        );
        break;

      case '/signup':
        if (props is SignupUsingMobileNumberPage) {
          return MaterialPageRoute(
            builder: (_) => SignupUsingMobileNumberPage(
              showProfile: props.showProfile,
            ),
          );
        }

        break;
      case '/create-user':
        if (props is CreateUserPage) {
          return MaterialPageRoute(
            builder: (_) => CreateUserPage(
              showProfile: props.showProfile,
              phoneNumber: props.phoneNumber,
              otp: props.otp,
            ),
          );
        }
        break;

      case '/brand':
        if (props is BrandPage) {
          return MaterialPageRoute(
            builder: (_) => BrandPage(
              brandName: props.brandName,
              slug: props.slug,
            ),
          );
        }
        break;
      case '/category':
        if (props is CategoryPage) {
          return MaterialPageRoute(
            builder: (_) => CategoryPage(
              categoryName: props.categoryName,
              slug: props.slug,
            ),
          );
        }
        break;
      case '/condition':
        if (props is ConditionPage) {
          return MaterialPageRoute(
            builder: (_) => ConditionPage(
              conditionName: props.conditionName,
              slug: props.slug,
            ),
          );
        }
        break;

      case '/seller-page':
        if (props is SellerPage) {
          return MaterialPageRoute(
            builder: (_) => SellerPage(
              sellerId: props.sellerId,
              sellerName: props.sellerName,
            ),
          );
        }
        break;

      case '/products':
        if (props is ProductsPage) {
          return MaterialPageRoute(
            builder: (_) => ProductsPage(
                title: props.title,
                brand: props.brand,
                category: props.category,
                condition: props.condition,
                searchByTitle: props.searchByTitle,
                productCode: props.productCode,
                pageNumber: props.pageNumber),
          );
        }
        break;
      case '/search':
        return MaterialPageRoute(
          builder: (_) => SearchPage(),
        );

        break;
      case '/product':
        if (props is ProductTile) {
          return MaterialPageRoute(
            builder: (_) => ProductTile(productId: props.productId),
          );
        }
        break;
      case '/product-images':
        if (props is ProductImages) {
          return MaterialPageRoute(
            builder: (_) =>
                ProductImages(imageUrls: props.imageUrls, index: props.index),
          );
        }
        break;
      case '/product-variants':
        if (props is ProductVariants) {
          return MaterialPageRoute(
            builder: (_) => ProductVariants(
                productCode: props.productCode,
                categoryCode: props.categoryCode),
          );
        }
        break;
      case '/product-details':
        if (props is ProductTile) {
          return MaterialPageRoute(
            builder: (_) => ProductTile(productId: props.productId),
          );
        }
        break;
      case '/ask-question':
        if (props is AskQuestion) {
          return MaterialPageRoute(
              builder: (_) => AskQuestion(
                    productId: props.productId,
                  ));
        }
        break;

      case '/orders':
        return MaterialPageRoute(
          builder: (_) => const Orderspage(),
        );
        break;
      case '/order':
        if (props is OrderTileNew) {
          return MaterialPageRoute(
            builder: (_) => OrderTileNew(
              orderId: props.orderId,
            ),
          );
        }
        break;
      case '/need-help':
        if (props is NeedHelpPage) {
          return MaterialPageRoute(
            builder: (_) => NeedHelpPage(
              orderId: props.orderId,
              orderNumber: props.orderNumber,
            ),
          );
        }
        break;
      case '/cancel-order':
        if (props is CancelOrderPage) {
          return MaterialPageRoute(
            builder: (_) => CancelOrderPage(
              orderId: props.orderId,
              orderNumber: props.orderNumber,
            ),
          );
        }
        break;
      case '/order-cancelled':
        if (props is OrderCancelled) {
          return MaterialPageRoute(
            builder: (_) => OrderCancelled(
              orderId: props.orderId,
            ),
          );
        }
        break;
      case '/review-product':
        if (props is CreateReviewPage) {
          return MaterialPageRoute(
            builder: (_) => CreateReviewPage(
              selectedRating: props.selectedRating,
              productId: props.productId,
            ),
          );
        }
        break;
      case '/update-review':
        if (props is EditReviewPage) {
          return MaterialPageRoute(
            builder: (_) => EditReviewPage(
                selectedRating: props.selectedRating,
                reviewId: props.reviewId,
                reviewContent: props.reviewContent,
                reviewTitle: props.reviewTitle),
          );
        }
        break;
      case '/cart':
        if (props is Cart) {
          return MaterialPageRoute(
            builder: (_) => Cart(
              enableBack: props.enableBack,
            ),
          );
        }
        break;
      case '/select-address':
        return MaterialPageRoute(
          builder: (_) => const SelectAddress(),
        );

        break;
      case '/select-pickup-store':
        return MaterialPageRoute(
          builder: (_) => const SelectPickUpStore(),
        );

        break;
      case '/order-summary':
        return MaterialPageRoute(
          builder: (_) => const OrderSummary(),
        );

        break;
      case '/apply-coupon':
        return MaterialPageRoute(
          builder: (_) => ApplyCouponPage(),
        );
        break;
      case '/create-order':
        if (props is CreateOrderPage) {
          return MaterialPageRoute(
            builder: (_) => CreateOrderPage(
              orderNumber: props.orderNumber,
            ),
          );
        }
        break;

      case '/wishlist':
        return MaterialPageRoute(
          builder: (_) => const Wishlist(),
        );
        break;
      case '/payment':
        if (props is PaymentPage) {
          return MaterialPageRoute(
            builder: (_) => PaymentPage(
              deliveryType: props.deliveryType,
            ),
          );
        }
        break;
      case '/addresses':
        return MaterialPageRoute(
          builder: (_) => const AddressesPage(),
        );
        break;
      case '/store-locations':
        return MaterialPageRoute(
          builder: (_) => const ShowStoreLocations(),
        );
        break;
      case '/create-address':
        if (props is CreateAddressPage) {
          return MaterialPageRoute(
            builder: (_) => CreateAddressPage(
              function: props.function,
              previousPage: props.previousPage,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const CreateAddressPage(),
          );
        }
        break;
      case '/edit-address':
        if (props is EditAddressPage) {
          return MaterialPageRoute(
            builder: (_) => EditAddressPage(
              address: props.address,
            ),
          );
        }
        break;
      case '/coupons':
        return MaterialPageRoute(
          builder: (_) => const Coupons(),
        );
        break;
      case '/refer':
        return MaterialPageRoute(
          builder: (_) => const ReferAndEarn(),
        );
        break;
      case '/coupon-referrals':
        return MaterialPageRoute(builder: (_) => const CouponReferralPage());
        break;
      case '/payment-details':
        return MaterialPageRoute(builder: (_) => const PaymentDetails());
        break;
      case '/reviews':
        return MaterialPageRoute(
          builder: (_) => const Reviews(),
        );
        break;
      case '/q-and-a':
        return MaterialPageRoute(
          builder: (_) => const QuestionAndAnswersPage(),
        );
        break;
      case '/q-and-a-tile':
        if (props is QuestionAndAnswersTile) {
          return MaterialPageRoute(
            builder: (_) => QuestionAndAnswersTile(
              questionAndAnswers: props.questionAndAnswers,
            ),
          );
        }
        break;
      case '/add-answer':
        if (props is AddAnswerPage) {
          return MaterialPageRoute(
              builder: (_) => AddAnswerPage(
                    questionId: props.questionId,
                    productTitle: props.productTitle,
                    questionTitle: props.questionTitle,
                    productId: props.productId,
                  ));
        }
        break;
      case '/faqs':
        return MaterialPageRoute(builder: (_) => const FaqsPage());
        break;

      default:
        return MaterialPageRoute(builder: (_) => UserMain());
    }
  }
}
