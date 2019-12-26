//
//  RTCManager.m
//  AgoraEducation
//
//  Created by SRS on 2019/12/23.
//  Copyright © 2019 Agora. All rights reserved.
//

#import "RTCManager.h"

@interface RTCManager()<AgoraRtcEngineDelegate>

@end

@implementation RTCManager
- (void)initEngineKit:(NSString *)appid {
    self.rtcEngineKit = [AgoraRtcEngineKit sharedEngineWithAppId:appid delegate:self];
}

- (int)joinChannelByToken:(NSString * _Nullable)token channelId:(NSString * _Nonnull)channelId info:(NSString * _Nullable)info uid:(NSUInteger)uid joinSuccess:(void(^ _Nullable)(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed))joinSuccessBlock {
    
    return [self.rtcEngineKit joinChannelByToken:token channelId:channelId info:info uid:uid joinSuccess:joinSuccessBlock];
}

- (void)setChannelProfile:(AgoraChannelProfile)channelProfile {
    [self.rtcEngineKit setChannelProfile: channelProfile];
}

- (void)setClientRole:(AgoraClientRole)clientRole {
    [self.rtcEngineKit setClientRole: clientRole];
}

- (void)enableVideo {
    [self.rtcEngineKit enableVideo];
}

- (void)startPreview {
    [self.rtcEngineKit startPreview];
}

- (void)enableWebSdkInteroperability:(BOOL) enabled {
    [self.rtcEngineKit enableWebSdkInteroperability: enabled];
}

- (void)enableDualStreamMode:(BOOL) enabled {
    [self.rtcEngineKit enableDualStreamMode: enabled];
}

- (int)setupLocalVideo:(AgoraRtcVideoCanvas * _Nullable)local {
    return [self.rtcEngineKit setupLocalVideo:local];
}
- (int)setupRemoteVideo:(AgoraRtcVideoCanvas * _Nonnull)remote {
    return [self.rtcEngineKit setupRemoteVideo:remote];
}

- (int)muteLocalVideoStream:(BOOL)enabled {
    return [self.rtcEngineKit muteLocalVideoStream:enabled];
}

- (int)muteLocalAudioStream:(BOOL)enabled {
    return [self.rtcEngineKit muteLocalAudioStream:enabled];
}

- (int)enableLocalVideo:(BOOL)enabled {
    return [self.rtcEngineKit enableLocalVideo:enabled];
}

- (int)enableLocalAudio:(BOOL)enabled {
    return [self.rtcEngineKit enableLocalAudio:enabled];
}

- (int)setRemoteVideoStream:(NSUInteger)uid type:(AgoraVideoStreamType)streamType {
    return [self.rtcEngineKit setRemoteVideoStream:uid type:streamType];
}

- (int)stopPreview {
    return [self.rtcEngineKit stopPreview];
}

- (void)releaseResources {
    [self stopPreview];
    [self.rtcEngineKit leaveChannel:nil];
}

-(void)dealloc {
    self.rtcEngineKit = nil;
    [self releaseResources];
}

#pragma mark AgoraRtcEngineDelegate
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {

    if([self.rtcManagerDelegate respondsToSelector:@selector(rtcEngine:didJoinedOfUid:elapsed:)]) {
        [self.rtcManagerDelegate rtcEngine:engine didJoinedOfUid:uid elapsed:elapsed];;
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    
    if([self.rtcManagerDelegate respondsToSelector:@selector(rtcEngine:didOfflineOfUid:reason:)]) {
        [self.rtcManagerDelegate rtcEngine:engine didOfflineOfUid:uid reason:reason];;
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine networkTypeChangedToType:(AgoraNetworkType)type {
    
    if([self.rtcManagerDelegate respondsToSelector:@selector(rtcEngine:networkTypeChangedToType:)]) {
        [self.rtcManagerDelegate rtcEngine:engine networkTypeChangedToType:type];;
    }
}

@end
