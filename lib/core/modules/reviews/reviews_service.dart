import 'package:ecomerce_app/core/modules/auth/provider.dart';
import 'package:ecomerce_app/core/modules/reviews/provider.dart';
import 'package:ecomerce_app/core/modules/reviews/review.dart';
import 'package:ecomerce_app/utils/replaced_range.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../products/product_model.dart';
import '../products/product_provider.dart';

class ReviewsService {
  ReviewsService(this.ref);
  final Ref ref;

  Future<void> submitReview({
    required ProductID productId,
    required Review review,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    // * we should only call this method when the user is signed in
    assert(user != null);
    if (user == null) {
      throw AssertionError(
          'Can\'t submit a review if the user is not signed in'.hardcoded);
    }
    await ref.read(reviewsRepositoryProvider).setReview(
          productId: productId,
          uid: user.uid,
          review: review,
        );
    // * Note: this should be done on the backend
    // * At this stage the review is already submitted
    // * and we don't need to await for the product rating to also be updated
    _updateProductRating(productId);
  }

  Future<void> _updateProductRating(ProductID productId) async {
    final reviews =
        await ref.read(reviewsRepositoryProvider).fetchReviews(productId);
    final avgRating = _avgReviewScore(reviews);
    await ref.read(productsRepositoryProvider).updateProductRating(
          productId: productId,
          avgRating: avgRating,
          numRatings: reviews.length,
        );
  }

  double _avgReviewScore(List<Review> reviews) {
    if (reviews.isNotEmpty) {
      var total = 0.0;
      for (var review in reviews) {
        total += review.rating;
      }
      return total / reviews.length;
    } else {
      return 0.0;
    }
  }
}

final reviewsServiceProvider = Provider<ReviewsService>((ref) {
  return ReviewsService(ref);
});

/// Check if a product was previously reviewed by the user
final userReviewFutureProvider =
    FutureProvider.autoDispose.family<Review?, ProductID>((ref, productId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref
        .watch(reviewsRepositoryProvider)
        .fetchUserReview(productId, user.uid);
  } else {
    return Future.value(null);
  }
});

/// Check if a product was previously reviewed by the user
final userReviewStreamProvider =
    StreamProvider.autoDispose.family<Review?, ProductID>((ref, productId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref
        .watch(reviewsRepositoryProvider)
        .watchUserReview(productId, user.uid);
  } else {
    return Stream.value(null);
  }
});
