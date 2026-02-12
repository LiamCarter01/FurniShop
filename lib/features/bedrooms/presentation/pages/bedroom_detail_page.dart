import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/state_widgets.dart' as core;
import '../../domain/entities/bedroom_entity.dart';
import '../providers/bedrooms_providers.dart';
import '../state/bedrooms_state.dart';

/// Bedroom detail page.
class BedroomDetailPage extends ConsumerStatefulWidget {
  final String bedroomId;
  const BedroomDetailPage({super.key, required this.bedroomId});

  @override
  ConsumerState<BedroomDetailPage> createState() => _BedroomDetailPageState();
}

class _BedroomDetailPageState extends ConsumerState<BedroomDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bedroomDetailProvider(widget.bedroomId).notifier).loadBedroom(widget.bedroomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bedroomDetailProvider(widget.bedroomId));

    return AppScaffold(
      title: '',
      transparentAppBar: true,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
        IconButton(onPressed: () => context.push(AppRoutes.cart), icon: const Icon(Icons.shopping_cart_outlined)),
      ],
      body: _buildBody(state),
    );
  }

  Widget _buildBody(BedroomDetailState state) {
    return switch (state) {
      BedroomDetailInitial() => const core.LoadingWidget(),
      BedroomDetailLoading() => const core.LoadingWidget(message: 'Loading...'),
      BedroomDetailLoaded(:final bedroom, :final quantity, :final totalPrice) =>
        _buildDetailContent(bedroom: bedroom, quantity: quantity, totalPrice: totalPrice),
      BedroomDetailError(:final message) => core.ErrorWidget(
        message: message,
        onRetry: () => ref.read(bedroomDetailProvider(widget.bedroomId).notifier).loadBedroom(widget.bedroomId),
      ),
    };
  }

  Widget _buildDetailContent({required Bedroom bedroom, required int quantity, required double totalPrice}) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: bedroom.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: AppColors.surfaceVariant, child: const Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => Container(color: AppColors.surfaceVariant, child: const Icon(Icons.broken_image_outlined, size: 64, color: AppColors.textHint)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal:12,vertical:4), decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(16)), child: AppText(text: bedroom.category[0].toUpperCase()+bedroom.category.substring(1), variant: AppTextVariant.labelSmall, color: AppColors.accent)),
                      const SizedBox(height:12),
                      AppText(text: bedroom.name, variant: AppTextVariant.headlineMedium),
                      const SizedBox(height:8),
                      Row(children: [Icon(Icons.star,size:20,color:Colors.amber[700]), const SizedBox(width:4), AppText(text: bedroom.rating.toStringAsFixed(1), variant: AppTextVariant.titleSmall,fontWeight:FontWeight.bold), const SizedBox(width:4), AppText(text:'(\${bedroom.reviewCount} reviews)',variant:AppTextVariant.bodySmall,color:AppColors.textSecondary), const Spacer(), if(!bedroom.inStock) Container(padding:const EdgeInsets.symmetric(horizontal:8,vertical:4), decoration:BoxDecoration(color:AppColors.error,borderRadius:BorderRadius.circular(4)), child: const AppText(text:'Out of Stock',variant:AppTextVariant.labelSmall,color:Colors.white))]),
                      const SizedBox(height:16), const Divider(), const SizedBox(height:16),
                      Row(children:[AppText.price(amount:bedroom.price), if(bedroom.hasDiscount)...[const SizedBox(width:8), AppText.originalPrice(amount:bedroom.originalPrice!), const SizedBox(width:8), Container(padding:const EdgeInsets.symmetric(horizontal:8,vertical:2), decoration:BoxDecoration(color:AppColors.success,borderRadius:BorderRadius.circular(4)), child: AppText(text:'-\${bedroom.discountPercentage}%',variant:AppTextVariant.labelSmall,color:Colors.white))]]),
                      const SizedBox(height:24), const AppText(text:'Description',variant:AppTextVariant.titleMedium), const SizedBox(height:8), AppText(text:bedroom.description,variant:AppTextVariant.bodyMedium,color:AppColors.textSecondary),
                      const SizedBox(height:24), const AppText(text:'Specifications',variant:AppTextVariant.titleMedium), const SizedBox(height:12), _buildSpecRow('Material', bedroom.material), _buildSpecRow('Color', bedroom.color), _buildSpecRow('Dimensions', bedroom.dimensions.formatted),
                      const SizedBox(height:24), if(bedroom.tags.isNotEmpty)...[const AppText(text:'Tags',variant:AppTextVariant.titleMedium), const SizedBox(height:8), Wrap(spacing:8,runSpacing:8,children:bedroom.tags.map((tag)=>Chip(label:Text(tag),backgroundColor:AppColors.surfaceVariant,padding:EdgeInsets.zero,materialTapTargetSize:MaterialTapTargetSize.shrinkWrap)).toList())],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildBottomBar(bedroom,quantity,totalPrice),
      ],
    );
  }

  Widget _buildSpecRow(String label,String value){return Padding(padding:const EdgeInsets.only(bottom:8),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[SizedBox(width:100,child:AppText(text:label,variant:AppTextVariant.bodyMedium,color:AppColors.textSecondary)),Expanded(child:AppText(text:value,variant:AppTextVariant.bodyMedium))]));}

  Widget _buildBottomBar(Bedroom bedroom,int quantity,double totalPrice){return Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:AppColors.surface,boxShadow:[BoxShadow(color:AppColors.shadow,blurRadius:8,offset:Offset(0,-2))]),child:SafeArea(child:Row(children:[Container(decoration:BoxDecoration(border:Border.all(color:AppColors.border),borderRadius:BorderRadius.circular(8)),child:Row(children:[IconButton(onPressed:quantity>1?()=>ref.read(bedroomDetailProvider(widget.bedroomId).notifier).decrementQuantity():null,icon:Icon(Icons.remove),iconSize:20,constraints:BoxConstraints(minWidth:40,minHeight:40)), SizedBox(width:40,child:Center(child:AppText(text:quantity.toString(),variant:AppTextVariant.titleMedium))),IconButton(onPressed:()=>ref.read(bedroomDetailProvider(widget.bedroomId).notifier).incrementQuantity(),icon:Icon(Icons.add),iconSize:20,constraints:BoxConstraints(minWidth:40,minHeight:40))])), const SizedBox(width:16), Expanded(child:AppButton(label:'Add to Cart - \$\${totalPrice.toStringAsFixed(2)}',onPressed:bedroom.inStock?(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('\$quantity x \$bedroom.name added to cart')));} : null,variant:AppButtonVariant.accent,size:AppButtonSize.large,leadingIcon:Icons.shopping_cart_outlined))]))) );}