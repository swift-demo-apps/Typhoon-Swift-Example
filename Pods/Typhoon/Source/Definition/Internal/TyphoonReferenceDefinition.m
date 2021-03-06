////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2014, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


#import "TyphoonReferenceDefinition.h"
#import "TyphoonDefinition+Infrastructure.h"
#import "TyphoonRuntimeArguments.h"
#import "TyphoonComponentFactory.h"
#import "TyphoonDefinition+InstanceBuilder.h"

//TODO: Merge TyphoonReferenceDefinition and TyphoonShortcutDefinition with keeping simple logic

@implementation TyphoonReferenceDefinition

+ (instancetype)definitionReferringToComponent:(NSString *)key
{
    return [[self alloc] initWithClass:[NSObject class] key:key];
}

@end

@implementation TyphoonShortcutDefinition {
    TyphoonRuntimeArguments *_referringArgs;
    NSString *_referringKey;
};

+ (instancetype)definitionWithKey:(NSString *)key referringTo:(TyphoonDefinition *)definition
{
    TyphoonShortcutDefinition *refDefinition = [[TyphoonShortcutDefinition alloc] initWithClass:definition.type key:key];
    refDefinition->_referringArgs = definition.currentRuntimeArguments;
    refDefinition->_referringKey = definition.key;
    return refDefinition;
}

- (id)targetForInitializerWithFactory:(TyphoonComponentFactory *)factory args:(TyphoonRuntimeArguments *)args
{
    if (_referringKey) {
        return [factory componentForKey:_referringKey args:[TyphoonRuntimeArguments argumentsFromRuntimeArguments:args appliedToReferenceArguments:_referringArgs]];
    } else {
        return [super targetForInitializerWithFactory:factory args:args];
    }
}

- (TyphoonMethod *)initializer
{
    return nil;
}

@end
