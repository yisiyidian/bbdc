
function AnalyticsChannel(channelId)
    if channelId ~= nil and string.len(channelId) > 0 then
        cx.CXAnalytics:logEventAndLabel('Channel', channelId)
    end
end

----------------------------------------------------------------------------------------

function AnalyticsTutorial(step)
    cx.CXAnalytics:logEventAndLabel('TutorialStep', tostring(step))
end

function AnalyticsSmallTutorial(step)
    cx.CXAnalytics:logEventAndLabel('TutorialSmallStep', tostring(step))
end

--function AnalyticsReviewBossTutorial(step)
--    cx.CXAnalytics:logEventAndLabel('ReviewBossTutorialStep', tostring(step))
--end

----------------------------------------------------------------------------------------

function AnalyticsDailyCheckIn(day)
    cx.CXAnalytics:logEventAndLabel('DailyCheckIn', tostring(day))
end

----------------------------------------------------------------------------------------

function AnalyticsSignUp_Guest()
    cx.CXAnalytics:logEventAndLabel('SignUp', 'Guest')
end

function AnalyticsSignUp_Normal()
    cx.CXAnalytics:logEventAndLabel('SignUp', 'Normal')
end

function AnalyticsSignUp_QQ()
    cx.CXAnalytics:logEventAndLabel('SignUp', 'QQ')
end

function AnalyticsAccountBind()
    cx.CXAnalytics:logEventAndLabel('AccountBind', 'YES')
end

function AnalyticsLogOut()
    cx.CXAnalytics:logEventAndLabel('LogOut', 'YES')
end

----------------------------------------------------------------------------------------

function AnalyticsWordsLibBtn()
    cx.CXAnalytics:logEventAndLabel('WordsLib', 'TOUCH')
end

----------------------------------------------------------------------------------------

function AnalyticsFriendBtn()
    cx.CXAnalytics:logEventAndLabel('Friend', 'TOUCH')
end

function AnalyticsFriendRequest()
    cx.CXAnalytics:logEventAndLabel('Friend', 'Request')
end

function AnalyticsFriendAccept()
    cx.CXAnalytics:logEventAndLabel('Friend', 'Accept')
end

----------------------------------------------------------------------------------------

function AnalyticsDataCenterBtn()
    cx.CXAnalytics:logEventAndLabel('DataCenter', 'TOUCH')
end

function AnalyticsDataCenterPage(pageName)
    cx.CXAnalytics:logEventAndLabel('DataCenter', pageName)
end

----------------------------------------------------------------------------------------

function AnalyticsChangeBookBtn()
    cx.CXAnalytics:logEventAndLabel('Book', 'TOUCH')
end

function AnalyticsBook(bookname)
    cx.CXAnalytics:logEventAndLabel('Book', 'selected_' .. bookname)
end

function AnalyticsDownloadBook(bookname)
    cx.CXAnalytics:logEventAndLabel('Book', 'download_' .. bookname)
end

----------------------------------------------------------------------------------------

function AnalyticsEnterLevelLayerBtn()
    cx.CXAnalytics:logEventAndLabel('EnterLevelLayer', 'TOUCH')
end

function AnalyticsTasksBtn()
    cx.CXAnalytics:logEventAndLabel('Tasks', 'TOUCH')
end

function AnalyticsTasksFinished(layerName)
    cx.CXAnalytics:logEventAndLabel('TasksFinished', layerName)
end

----------------------------------------------------------------------------------------

-- 点击 重玩错词
function AnalyticsReplayWrongWordsBtn()
    cx.CXAnalytics:logEventAndLabel('ReplayWrongWords', 'TOUCH')
end

-- 点击 依然复习
function AnalyticsContinueReviewBtn()
    cx.CXAnalytics:logEventAndLabel('ContinueReview', 'TOUCH')
end

-- 点击 下一步
function AnalyticsStudyNextBtn()
    cx.CXAnalytics:logEventAndLabel('StudyNext', 'TOUCH')
end

-- 猜错
function AnalyticsStudyGuessWrong()
    cx.CXAnalytics:logEventAndLabel('answerWordMeaning', 'GuessWrong')
end

-- 答对
function AnalyticsStudyAnswerRight()
    cx.CXAnalytics:logEventAndLabel('answerWordMeaning', 'AnswerRight')
end

-- 不会
function AnalyticsStudyDontKnowAnswer()
    cx.CXAnalytics:logEventAndLabel('answerWordMeaning', 'DontKnowAnswer')
end

-- 猜错
function AnalyticsStudyGuessWrong_strikeWhileHot()
    cx.CXAnalytics:logEventAndLabel('answerWordMeaningHOT', 'GuessWrong')
end

-- 答对
function AnalyticsStudyAnswerRight_strikeWhileHot()
    cx.CXAnalytics:logEventAndLabel('answerWordMeaningHOT', 'AnswerRight')
end

-- 不会
function AnalyticsStudyDontKnowAnswer_strikeWhileHot()
    cx.CXAnalytics:logEventAndLabel('answerWordMeaningHOT', 'DontKnowAnswer')
end

-- 点击 跳过划单词步骤
function AnalyticsStudySkipSwipeWord()
    cx.CXAnalytics:logEventAndLabel('SkipSwipeWord', 'TOUCH')
end

-- 点击 生词回看
function AnalyticsStudyLookBackWord()
    cx.CXAnalytics:logEventAndLabel('LookBackWord', 'TOUCH')
end

function AnalyticsStudySlideCoconut_EnterLayer()
    if s_CURRENT_USER ~= nil and s_CURRENT_USER ~= '' then
        if is2TimeInSameDay(os.time(),s_CURRENT_USER.localTime) then
            cx.CXAnalytics:logEventAndLabel('SlideCoconut_EnterLayer_firstday', 'TOUCH')
        end
    end
    cx.CXAnalytics:logEventAndLabel('SlideCoconut_EnterLayer', 'TOUCH')
end

function AnalyticsStudySlideCoconut_LeaveLayer()
    if s_CURRENT_USER ~= nil and s_CURRENT_USER ~= '' then
        if is2TimeInSameDay(os.time(),s_CURRENT_USER.localTime) then
            cx.CXAnalytics:logEventAndLabel('SlideCoconut_LeaveLayer_firstday', 'TOUCH')
        end
    end
    cx.CXAnalytics:logEventAndLabel('SlideCoconut_LeaveLayer', 'TOUCH')
end

function AnalyticsStudyCollectAllWord()
    if s_CURRENT_USER ~= nil and s_CURRENT_USER ~= '' then
        if is2TimeInSameDay(os.time(),s_CURRENT_USER.localTime) then
            cx.CXAnalytics:logEventAndLabel('CollectAllWord_firstday', 'TOUCH')
        end
    end
    cx.CXAnalytics:logEventAndLabel('CollectAllWord', 'TOUCH')
end

function AnalyticsForgeIron_EnterLayer()
    if s_CURRENT_USER ~= nil and s_CURRENT_USER ~= '' then
        if is2TimeInSameDay(os.time(),s_CURRENT_USER.localTime) then
            cx.CXAnalytics:logEventAndLabel('ForgeIron_EnterLayer_firstday', 'TOUCH')
        end
    end
    cx.CXAnalytics:logEventAndLabel('ForgeIron_EnterLayer', 'TOUCH')
end

function AnalyticsForgeIron_LeaveLayer()
    if s_CURRENT_USER ~= nil and s_CURRENT_USER ~= '' then
        if is2TimeInSameDay(os.time(),s_CURRENT_USER.localTime) then
            cx.CXAnalytics:logEventAndLabel('ForgeIron_LeaveLayer_firstday', 'TOUCH')
        end
    end
    cx.CXAnalytics:logEventAndLabel('ForgeIron_LeaveLayer', 'TOUCH')
end
function AnalyticsFirstDayEnterSecondIsland()
    local bossList = s_LocalDatabaseManager.getAllBossInfo()
    if bossList == nil then
        return
    end
    if #bossList == 2 and is2TimeInSameDay(os.time(),s_CURRENT_USER.localTime) and  #s_LocalDatabaseManager.getBossInfo(1).rightWordList == 0 and #s_LocalDatabaseManager.getBossInfo(1).wrongWordList == 0 then
        cx.CXAnalytics:logEventAndLabel('FirstDayEnterSecondIsland', 'TOUCH')
    end
    if #bossList == 2 then
    cx.CXAnalytics:logEventAndLabel('EnterSecondIsland', 'TOUCH')
    end
end

----------------------------------------------------------------------------------------

function AnalyticsReviewBoss()
    cx.CXAnalytics:logEventAndLabel('ReviewBoss', 'SHOW')
end

function AnalyticsReviewBoss_EnterLayer()
    if s_CURRENT_USER ~= nil and s_CURRENT_USER ~= '' then
        if is2TimeInSameDay(os.time(),s_CURRENT_USER.localTime) then
            cx.CXAnalytics:logEventAndLabel('ReviewBoss_EnterLayer_firstday', 'TOUCH')
        end
    end
    cx.CXAnalytics:logEventAndLabel('ReviewBoss_EnterLayer', 'SHOW')
end

function AnalyticsReviewBoss_LeaveLayer()
    if s_CURRENT_USER ~= nil and s_CURRENT_USER ~= '' then
        if is2TimeInSameDay(os.time(),s_CURRENT_USER.localTime) then
            cx.CXAnalytics:logEventAndLabel('ReviewBoss_LeaveLayer_firstday', 'TOUCH')
        end
    end
    cx.CXAnalytics:logEventAndLabel('ReviewBoss_LeaveLayer', 'SHOW')
end
----------------------------------------------------------------------------------------

function AnalyticsSummaryBoss()
    cx.CXAnalytics:logEventAndLabel('SummaryBoss', 'SHOW')
end

function AnalyticsSummaryBossInFirstDay()
    cx.CXAnalytics:logEventAndLabel('SummaryBossInFirstDay', 'SHOW')
end

function AnalyticsSummaryBossWordCount(cnt)
    cx.CXAnalytics:logEventAndLabel('SummaryBoss', 'wordsCount_' .. tostring(cnt))
end

function AnalyticsSummaryBossResult(result)
    cx.CXAnalytics:logEventAndLabel('SummaryBoss', result)
end

function AnalyticsSummaryBossResultInFirstDay(result)
    cx.CXAnalytics:logEventAndLabel('SummaryBossInFirstDay', result)
end

function AnalyticsPassSecondSummaryBossInFirstDay()
    cx.CXAnalytics:logEventAndLabel('PassSecondSummaryBossInFirstDay', 'SHOW')
end

----------------------------------------------------------------------------------------

function AnalyticsChestGeneratedCnt(cnt)
    cx.CXAnalytics:logEventAndLabel('ChestGeneratedCnt', tostring(cnt))
end

function AnalyticsChestCollectedCnt(name)
    cx.CXAnalytics:logEventAndLabel('ChestCollectedCnt', name)
end

function Analytics_applicationDidEnterBackground(layerName)
    cx.CXAnalytics:logEventAndLabel('AppEnterBackground', layerName)
end

function Analytics_replaceGameLayer(layerName)
    cx.CXAnalytics:logEventAndLabel('replaceGameLayer', layerName)
end

----------------------------------------------------------------------------------------

function AnalyticsButtonToShare()
    cx.CXAnalytics:logEventAndLabel('Share', 'TOUCH')
end

function AnalyticsButtonToShareInFirstDay()
    cx.CXAnalytics:logEventAndLabel('ShareInFirstDay', 'TOUCH')
end

function AnalyticsShare(name)
    cx.CXAnalytics:logEventAndLabel('Share', name)
end

function AnalyticsEnterShare()
    cx.CXAnalytics:logEventAndLabel('Share', 'ENTER')
end

function AnalyticsEnterShareInFirstDay()
    cx.CXAnalytics:logEventAndLabel('ShareInFirstDay', 'ENTER')
end

----------------------------------------------------------------------------------------

function AnalyticsDownloadSoundBtn()
    cx.CXAnalytics:logEventAndLabel('DownloadSound', 'TOUCH')
end

function AnalyticsBuy(itemId)
    cx.CXAnalytics:logEventAndLabel('BuyProduct', tostring(itemId))
end

function AnalyticsShopBtn()
    cx.CXAnalytics:logEventAndLabel('Shop', 'TOUCH')
end

----------------------------------------------------------------------------------------

function AnalyticsImproveInfo()
    cx.CXAnalytics:logEventAndLabel('AnalyticsImproveInfo', 'SHOW')
end



----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
-- first
ANALYTICS_FIRST_BOOK = 0
ANALYTICS_FIRST_LEVEL = 1

ANALYTICS_FIRST_STUDY = 2
ANALYTICS_FIRST_SKIP_REVIEW = 3
ANALYTICS_FIRST_DONT_KNOW = 4
ANALYTICS_FIRST_SWIPE_WORD = 5

ANALYTICS_FIRST_GOT_ENOUGH_UNKNOWN_WORDS = 6

ANALYTICS_FIRST_STUDY_STRIKEWHILEHOT = 7
ANALYTICS_FIRST_SKIP_REVIEW_STRIKEWHILEHOT = 8
ANALYTICS_FIRST_DONT_KNOW_STRIKEWHILEHOT = 9
ANALYTICS_FIRST_SWIPE_WORD_STRIKEWHILEHOT = 10
ANALYTICS_FIRST_FINISH = 11

ANALYTICS_FIRST_REVIEW_BOSS = 12
ANALYTICS_FIRST_REVIEW_BOSS_RESULT = 13

local ANALYTICS_FIRST_EVENTS = {
    'firstBook', 'firstLevelScene', 
    'firstStudy', 'firstSkipReview', 'firstDontKnow', 'firstSwipeWord', 
    'firstGotEnoughUnknownWords', 
    'firstStudyStrikeWhileHot', 'firstSkipReviewStrikeWhileHot', 'firstDontKnowStrikeWhileHot', 'firstSwipeWordStrikeWhileHot', 'firstFinish',
    'firstReviewBoss', 'firstReviewBossResult'
}

function AnalyticsFirst(eventindex, eventDes)
    if math["and"](s_CURRENT_USER.statsMask, (2 ^ eventindex)) == 0 then
        local event = ANALYTICS_FIRST_EVENTS[eventindex + 1]
        cx.CXAnalytics:logEventAndLabel(event, eventDes)

        if s_SERVER.isNetworkConnectedNow() and string.len(s_CURRENT_USER.objectId) > 0 then
            s_CURRENT_USER.statsMask = s_CURRENT_USER.statsMask + (2 ^ eventindex)
            local obj = {['className']=s_CURRENT_USER.className, ['objectId']=s_CURRENT_USER.objectId, ['statsMask']=s_CURRENT_USER.statsMask}
            s_SERVER.updateData(obj, nil, nil)
        end
    end
end

----------------------------------------------------------------------------------------

