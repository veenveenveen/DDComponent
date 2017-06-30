// MIT License
//
// Copyright (c) 2016 Daniel (djs66256@163.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "DDCollectionViewSectionComponent.h"
#import "DDCollectionViewComponent+Private.h"

@implementation DDCollectionViewSectionComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineSpacing = DDComponentAutomaticDimension;
        _itemSpacing = DDComponentAutomaticDimension;
        _sectionInset = UIEdgeInsetsMake(DDComponentAutomaticDimension, DDComponentAutomaticDimension, DDComponentAutomaticDimension, DDComponentAutomaticDimension);
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = self.size;
    BOOL autoWidth = size.width == DDComponentAutomaticDimension;
    BOOL autoHeight = size.height == DDComponentAutomaticDimension;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (autoWidth || autoHeight) {
        inset = [self collectionView:collectionView
                              layout:collectionViewLayout
              insetForSectionAtIndex:indexPath.section];
    }
    if (autoWidth) {
        size.width = collectionView.frame.size.width - inset.left - inset.right;
    }
    if (autoHeight) {
        size.height = collectionView.frame.size.height - inset.top - inset.bottom;
    }
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = self.headerSize;
    BOOL autoWidth = size.width == DDComponentAutomaticDimension;
    BOOL autoHeight = size.height == DDComponentAutomaticDimension;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (autoWidth || autoHeight) {
        inset = [self collectionView:collectionView
                              layout:collectionViewLayout
              insetForSectionAtIndex:section];
    }
    if (autoWidth) {
        size.width = collectionView.frame.size.width - inset.left - inset.right;
    }
    if (autoHeight) {
        size.height = collectionView.frame.size.height - inset.top - inset.bottom;
    }
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size = self.footerSize;
    BOOL autoWidth = size.width == DDComponentAutomaticDimension;
    BOOL autoHeight = size.height == DDComponentAutomaticDimension;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (autoWidth || autoHeight) {
        inset = [self collectionView:collectionView
                                       layout:collectionViewLayout
                       insetForSectionAtIndex:section];
    }
    if (autoWidth) {
        size.width = collectionView.frame.size.width - inset.left - inset.right;
    }
    if (autoHeight) {
        size.height = collectionView.frame.size.height - inset.top - inset.bottom;
    }
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (_lineSpacing == DDComponentAutomaticDimension || isnan(_lineSpacing)) ? ((UICollectionViewFlowLayout *)collectionViewLayout).minimumLineSpacing : _lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (_itemSpacing == DDComponentAutomaticDimension || isnan(_itemSpacing)) ? ((UICollectionViewFlowLayout *)collectionViewLayout).minimumInteritemSpacing : _itemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets inset = ((UICollectionViewFlowLayout *)collectionViewLayout).sectionInset;
    if (_sectionInset.top != DDComponentAutomaticDimension && !isnan(_sectionInset.top)) {
        inset.top = _sectionInset.top;
    }
    if (_sectionInset.left != DDComponentAutomaticDimension && !isnan(_sectionInset.left)) {
        inset.left = _sectionInset.left;
    }
    if (_sectionInset.right != DDComponentAutomaticDimension && !isnan(_sectionInset.right)) {
        inset.right = _sectionInset.right;
    }
    if (_sectionInset.bottom != DDComponentAutomaticDimension && !isnan(_sectionInset.bottom)) {
        inset.bottom = _sectionInset.bottom;
    }
    return inset;
}

@end


@implementation DDCollectionViewHeaderFooterSectionComponent

- (void)setHeaderComponent:(DDCollectionViewSectionComponent *)headerComponent {
    if (_headerComponent.superComponent == self) _headerComponent.superComponent = nil;
    _headerComponent = headerComponent;
    _headerComponent.superComponent = self;
    if (self.collectionView) [_headerComponent prepareCollectionView];
}

- (void)setFooterComponent:(DDCollectionViewSectionComponent *)footerComponent {
    if (_footerComponent.superComponent == self) _footerComponent.superComponent = nil;
    _footerComponent = footerComponent;
    _footerComponent.superComponent = self;
    if (self.collectionView) [_footerComponent prepareCollectionView];
}

- (void)setHeaderFooterComponent:(DDCollectionViewSectionComponent *)headerFooterComponent {
    if (_headerFooterComponent.superComponent == self) _headerFooterComponent.superComponent = nil;
    _headerFooterComponent = headerFooterComponent;
    _headerFooterComponent.superComponent = self;
    if (self.collectionView) [_headerFooterComponent prepareCollectionView];
}

- (void)prepareCollectionView {
    [super prepareCollectionView];
    if (self.collectionView) {
        [_headerFooterComponent prepareCollectionView];
        [_headerComponent prepareCollectionView];
        [_footerComponent prepareCollectionView];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DDCollectionViewBaseComponent *comp = _headerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
            return [comp collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        }
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        DDCollectionViewBaseComponent *comp = _footerComponent ?: _headerFooterComponent;
        if ([comp respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
            return [comp collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        }
    }
    NSAssert(false, @"%@ is nil!", kind);
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    DDCollectionViewBaseComponent *comp = _headerComponent ?: _headerFooterComponent;
    if ([comp respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        return [comp collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    DDCollectionViewBaseComponent *comp = _footerComponent ?: _headerFooterComponent;
    if ([comp respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
        return [comp collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
    }
    return CGSizeZero;
}

- (NSString *)debugDescription {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:self.description];
    if (self.headerComponent) {
        [desc appendString:@"\n  [Header] "];
        [desc appendString:[[self.headerComponent.debugDescription componentsSeparatedByString:@"\n"] componentsJoinedByString:@"\n    "]];
    }
    if (self.footerComponent) {
        [desc appendString:@"\n  [Footer] "];
        [desc appendString:[[self.footerComponent.debugDescription componentsSeparatedByString:@"\n"] componentsJoinedByString:@"\n    "]];
    }
    if (self.headerFooterComponent) {
        [desc appendString:@"\n  [HeaderFooter] "];
        [desc appendString:[[self.headerFooterComponent.debugDescription componentsSeparatedByString:@"\n"] componentsJoinedByString:@"\n    "]];
    }
    return desc;
}

@end

@implementation DDCollectionViewItemGroupComponent

- (void)setSubComponents:(NSArray *)subComponents {
    for (DDCollectionViewBaseComponent *comp in _subComponents) {
        if (comp.superComponent == self) {
            comp.superComponent = nil;
        }
    }
    _subComponents = subComponents;
    for (DDCollectionViewBaseComponent *comp in _subComponents) {
        comp.superComponent = self;
        if (self.collectionView) {
            [comp prepareCollectionView];
        }
    }
}

- (void)prepareCollectionView {
    [super prepareCollectionView];
    if (self.collectionView) {
        for (DDCollectionViewBaseComponent *comp in _subComponents) {
            [comp prepareCollectionView];
        }
    }
}

- (DDCollectionViewBaseComponent *)componentAtItem:(NSInteger)atItem {
    if (self.collectionView) {
        NSInteger item = self.item;
        NSInteger section = self.section;
        for (DDCollectionViewBaseComponent *comp in _subComponents) {
            NSInteger count = [comp collectionView:self.collectionView numberOfItemsInSection:section];
            if (item <= atItem && item+count > atItem) {
                return comp;
            }
            item += count;
        }
    }
    return nil;
}

- (NSInteger)firstItemOfSubComponent:(id<DDCollectionViewComponent>)subComp {
    if (self.collectionView) {
        NSInteger item = self.item;
        NSInteger section = self.section;
        for (DDCollectionViewBaseComponent *comp in _subComponents) {
            if (comp == subComp) {
                return item;
            }
            else {
                item += [comp collectionView:self.collectionView numberOfItemsInSection:section];
            }
        }
    }
    return 0;
}

- (NSInteger)firstSectionOfSubComponent:(id<DDCollectionViewComponent>)subComp {
    return self.section;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = 0;
    for (DDCollectionViewBaseComponent *comp in _subComponents) {
        count += [comp collectionView:collectionView numberOfItemsInSection:section];
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    return [comp collectionView:collectionView cellForItemAtIndexPath:indexPath];
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView shouldHighlightItemAtIndexPath:indexPath];
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView didHighlightItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView didUnhighlightItemAtIndexPath:indexPath];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView shouldSelectItemAtIndexPath:indexPath];
    }
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView shouldDeselectItemAtIndexPath:indexPath];
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        [comp collectionView:collectionView didEndDisplayingCell:cell forItemAtIndexPath:indexPath];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewBaseComponent *comp = [self componentAtItem:indexPath.item];
    if ([comp respondsToSelector:_cmd]) {
        return [comp collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    return CGSizeZero;
}

- (NSString *)debugDescription {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:[super debugDescription]];
    if (self.subComponents.count) {
        [desc appendString:@"\n  [SubComponents]"];
        for (DDCollectionViewBaseComponent *comp in self.subComponents) {
            [desc appendString:@"\n    "];
            NSArray *descs = [comp.debugDescription componentsSeparatedByString:@"\n"];
            [desc appendString:[descs componentsJoinedByString:@"\n    "]];
        }
    }
    return desc;
}

@end
