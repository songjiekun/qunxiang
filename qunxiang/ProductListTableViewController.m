//
//  ProductListTableViewController.m
//  qunxiang
//
//  Created by song jiekun on 15/6/3.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ProductListTableViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AppDelegate.h"
#import "ProductSectionHeader.h"

@interface ProductListTableViewController ()<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end


@implementation ProductListTableViewController

//@synthesize mainProducts,lastProductDate;

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        //初始化mainProduct
        //self.mainProducts=[[NSMutableArray alloc] initWithCapacity:4];
        
        /*
        for (NSInteger i = 0; i < 4; ++i) {
            NSNumber *newPrice = [NSNumber numberWithFloat:(11.1+i)];
            Product *newProduct = [Product productOfDescription:@"产品1" category:@"分类1" price:newPrice image:[UIImage imageNamed:@"test1.jpg"] createdDate:[NSDate date] updatedDate:[NSDate date]];
            [self.mainProducts addObject:newProduct];
        }
         */
        
        
        
        self.imageCache=[[NSCache alloc] init];
        
        self.ioQueue=[[NSOperationQueue alloc] init];
        self.ioQueue.maxConcurrentOperationCount=40;
        
        self.internetQueue=[[NSOperationQueue alloc] init];
        self.internetQueue.maxConcurrentOperationCount=10;
        
        // Initialize Fetch Request
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Product"];
        
        // Add Sort Descriptors
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO]]];
        
        // Initialize Fetched Results Controller
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext=app.managedObjectContext;
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        // Configure Fetched Results Controller
        self.fetchedResultsController.delegate=self;
        
        // Perform Fetch
        NSError *error = nil;
        [self.fetchedResultsController performFetch:&error];
        
        if (error) {
            NSLog(@"Unable to perform fetch.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
        
        //初始化最后一个product的日期
        self.lastProductDate= ((ProductMore*)[self.fetchedResultsController.fetchedObjects lastObject]).createdAt;
        
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //SVPPullToRefresh设置
    __weak ProductListTableViewController *wSelf=self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [ProductMore reloadProducts:wSelf action:@selector(refreshProducts) beforeDate:nil context:wSelf.managedObjectContext];
        
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        
        [ProductMore reloadProducts:wSelf action:@selector(loadMoreProducts) beforeDate:wSelf.lastProductDate  context:wSelf.managedObjectContext];
        
    }];
    
    //注册 custom tableviewcell
    UINib *nib = [UINib nibWithNibName:@"ProductTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ProductTableViewCell"];
    //[self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"ProductSectionHeader"];
    [self.tableView registerClass:[ProductSectionHeader class] forHeaderFooterViewReuseIdentifier:@"ProductSectionHeader"];
    
    //ios 8设置tableview的高度
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
        
        self.tableView.rowHeight= UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight=200;
    }
    
    //去掉系统默认分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - segue


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"ShowProductDetail"]) {
        
        NSIndexPath *indexPath= [self.tableView indexPathForSelectedRow];
        ProductDetailViewController *destinationVC=segue.destinationViewController;
    
        ProductMore *product = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
        destinationVC.product=product;
        destinationVC.imageCache=self.imageCache;
        destinationVC.ioQueue=self.ioQueue;
        destinationVC.internetQueue=self.internetQueue;
        
        ///init pageviews
        destinationVC.pageViews=[[NSMutableArray alloc] initWithCapacity:5];
        
        for (NSInteger i = 0; i < 5; ++i) {
            [destinationVC.pageViews addObject:[NSNull null]];
        }
        
    }
    
}


#pragma mark - fetchedResultsController delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView beginUpdates];
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    //初始化最后一个product的日期
    //self.lastProductDate= ((ProductMore*)[self.fetchedResultsController.fetchedObjects lastObject]).createdAt;
    [self.tableView endUpdates];
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:(ProductTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

- (void)configureCell:(ProductTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    // Fetch Record
    ProductMore *product = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //设置imageWithCache的代理
    ImageWithCacheMore *firstImage=(ImageWithCacheMore *)[product.images firstObject];
    firstImage.delegate=self;
    //更新Cell
    cell.productCategory.text=product.productCategory;
    cell.productDescription.text=product.productDescription;
    cell.productPrice.text=[product.productPrice stringValue];
    cell.productImage.image=[firstImage retrieveImage:cell fromCache:self.imageCache atIOQueue:self.ioQueue atInternetQueue:self.internetQueue];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductTableViewCell" forIndexPath:indexPath];
    //cell.contentView.translatesAutoresizingMaskIntoConstraints=NO;
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ProductSectionHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ProductSectionHeader"];
    
    return headerView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"ShowProductDetail" sender:tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
        
        return UITableViewAutomaticDimension;
    }
    else {
        
        return 200;
    }
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 刷新products列表
- (void)refreshProducts{
    
    /*
    [self.mainProducts removeAllObjects];
    self.mainProducts=reloadedProducts;
    //最后一个product的日期
    self.lastProductDate=((Product*)[self.mainProducts lastObject]).createdAt;
    
    [self.tableView reloadData];
    [self.tableView.pullToRefreshView stopAnimating];
    */
    //////
    
    //由于fetchedResultsController 的代理还没有调用  所以fetchedobjects没有变化过
    NSArray *fetchedObjects = self.fetchedResultsController.fetchedObjects;
    
    for(ProductMore *product in fetchedObjects)
    {
        
        [self.managedObjectContext deleteObject:product];
        
    }
    

    NSError *deleteError = nil;
    
    //调用save后 会强行调用fetchedResultsController的delegate
    if (![self.managedObjectContext save:&deleteError]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
    }
    
    //初始化最后一个product的日期
    //self.lastProductDate= ((ProductMore*)[self.fetchedResultsController.fetchedObjects lastObject]).createdAt;
    
    [self.tableView.pullToRefreshView stopAnimating];
    
}

#pragma mark - 载入更多products列表
- (void)loadMoreProducts{
    
    /*
    //刷新前的table列表数量
    NSUInteger currentRowCount=self.mainProducts.count;
    
    //把新的数据加入数据源
    [self.mainProducts addObjectsFromArray:reloadedProducts];
    //最后一个product的日期
    self.lastProductDate=((Product*)[self.mainProducts lastObject]).createdAt;
    
    //设置新添加的列表路径
    NSMutableArray *indexPaths=[[NSMutableArray alloc] initWithCapacity:reloadedProducts.count];
    for (int i=0; i<reloadedProducts.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:currentRowCount+i inSection:0]];
    }
    
    //插入列表
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
     */
    
    
    
    
    NSError *deleteError = nil;
    
    if (![self.managedObjectContext save:&deleteError]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
    }
    
    
    //最后一个product的日期
    self.lastProductDate= ((ProductMore*)[self.fetchedResultsController.fetchedObjects lastObject]).createdAt;
    
    //停止刷新
    [self.tableView.infiniteScrollingView stopAnimating];
    
    
    
}


#pragma mark - ImageWithCache的代理
-(void)refreshImage:(ImageWithCache *)sender withImage:(UIImage *)newImage{
    
    
    
    for (ProductMore *product in self.fetchedResultsController.fetchedObjects) {
        
        ImageWithCacheMore *firstImage=(ImageWithCacheMore *)[product.images firstObject];
        
        if (firstImage==sender) {
            
            NSInteger productIndex = [self.fetchedResultsController.fetchedObjects indexOfObject:product];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:productIndex inSection:0];
            
            ProductTableViewCell *cell = (ProductTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            
            if (cell) {
                
                cell.productImage.image=newImage;
                
                cell.productImage.alpha=0;
                
                
                //图片淡入淡出
                [UIView animateWithDuration:0.3 animations:^{
                    
                    cell.productImage.alpha=1;
                    
                }];
                
                
            }
            
            return;
            
        }
        
    }
    
}
     
     
@end
