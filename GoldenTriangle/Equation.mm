//
//  Equation.m
//  GoldenTriangle
//
//  Created by Sergey Harchenko on 6/5/13.
//
//

#import "Equation.h"

@interface Equation()

@property (nonatomic, strong) NSMutableDictionary* kerDic;

@end

void writeResToFile(const char * file_name, double ** mat, int n, int m, double x_b, double x_h, double x_e, double y_b, double y_h, double y_e);

void writeResToFile(const char * file_name, double ** mat, int n, int m, double x_b, double x_h, double x_e, double y_b, double y_h, double y_e){
    FILE* file  = fopen(file_name, "w");
    fprintf(file, "x = [ %f : %f : %f ];\n", x_b, x_h, x_e);
    fprintf(file, "y = [ %f : %f : %f ];\n", y_b, y_h, y_e);
    fprintf(file, "z = [\n");
    for(int i = 0; i < n; ++i){
        fprintf(file, "[ ");
        for(int j = 0; j < m; ++j){
            fprintf(file, "%f, ", mat[i][j]);
        }
        fprintf(file, "]\n");
    }
    fprintf(file, "];\n");
    fprintf(file, "surf(x,y,z);");
    fclose(file);
}

@implementation Equation

-(id)init{
    self = [super init];
    assert(self);
    normalDestr = new NormalizeDestribution(7, 2);
    return self;
}

-(double)Kx:(double)x s:(double)s y:(double)y l:(double)l{
    
    return normalDestr->density(x - s) * normalDestr->density(y - l);
}
-(double)fx:(double)x y:(double)y{
    return (1 - normalDestr->destribution_function(y)) * normalDestr->destribution_function(x);
}

-(NSArray *)solutionForx:(double)x y:(double)y{
    double h = 0.01;
    int x_size = x / h + 1;
    int y_size = y / h + 1;
    
    double ** c_result = (double **)malloc(sizeof(double *) * x_size);
    double** K = (double **)malloc(sizeof(double *) * x_size);
    for(int i = 0; i < x_size; ++i){
        K[i] = (double *)malloc(sizeof(double) * y_size);
        c_result[i] = (double *)malloc(sizeof(double) * y_size);
    }
    
    for(int i = 0; i < x_size; ++i){
        for(int j = 0; j < y_size; ++j){
            K[i][j] = MAXFLOAT;
        }
    }
    
    for(int i = 0; i < x_size; ++i){
        NSLog(@"Row: %i", i);
        for(int j = 0; j < y_size; ++j){
            double z = 0;
            if(i == 0 || j == 0){
                z = [self fx:i*h y:j*h];
            }else{
                for(int k = 1; k < i; ++k){
                    for(int l = 1; l< j; ++l){
                        double K1, K2;
                        if(K[i - k][j - l] != MAXFLOAT){
                            K1 = K[i - k][j - l];
                        }else{
                            K1 = [self Kx:i*h s:k*h y:j*h l:l*h];
                            K[i - k][j - l] = K1;
                        }
                        
                        if(K[i - k + 1][j - l + 1] != MAXFLOAT){
                            K2 = K[i - k + 1][j - l + 1];
                        }else{
                            K2 = [self Kx:i*h s:(k-1)*h y:j*h l:(l - 1)*h];
                            K[i - k + 1][j - l + 1] = K2;
                        }
                        
                        z += ( K1 * (c_result[k][l])+  K2 * (c_result[k -1][l-1]));
                    }
                }
                
                double KT;
                
                if(K[1][1] != MAXFLOAT){
                    KT = K[1][1];
                }else{
                    KT = [self Kx:i*h s:(i - 1)*h y:j*h l:(j - 1)*h];
                    K[1][1] = KT;
                }
                
                z += KT * (c_result[i -1][j - 1]);
                z*=(pow(h, 2) / 2.);
                z+=[self fx:i*h y:j*h];
                if(K[0][0] != MAXFLOAT){
                    KT = K[0][0];
                }else{
                    KT = [self Kx:i*h s:(i - 1)*h y:j*h l:(j - 1)*h];
                    K[0][0] = KT;
                }
                z = z / (1 - pow(h, 2) * KT / 2.);
            }
            c_result[i][j] = z;
        }
    }
    writeResToFile("resultvn_7_2.m", c_result, x_size, y_size, 0, h, x, 0, h, y);
    return nil;
}

-(NSArray *)solutionForFile:(NSString *)fileName{
    return [NSArray arrayWithContentsOfFile:fileName];
}


@end
