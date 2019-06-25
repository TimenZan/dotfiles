"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var rxjs_1 = require("rxjs");
/**
 * will cache the source observable values until inner observable is complete,
 * then the cache values will trigger as array
 */
function bufferMap(fn) {
    var isComplete = false;
    var values = [];
    var resultSubp;
    var subp;
    var doNext = function (observer) {
        var params = values;
        values = [];
        try {
            subp = fn(params).subscribe({
                next: function (res) { return observer.next(res); },
                error: function (err) { return observer.error(err); },
                complete: function () {
                    if (values.length !== 0) {
                        doNext(observer);
                    }
                    else if (isComplete) {
                        isComplete = true;
                        observer.complete();
                    }
                }
            });
        }
        catch (err) {
            isComplete = true;
            return observer.error(err);
        }
    };
    return function (preObs) {
        return rxjs_1.Observable.create(function (observer) {
            resultSubp = preObs.subscribe({
                next: function (res) {
                    values.push(res);
                    if (subp === undefined || subp.closed) {
                        doNext(observer);
                    }
                },
                error: function (err) {
                    isComplete = true;
                    return observer.error(err);
                },
                complete: function () {
                    isComplete = true;
                    if (!values.length && subp.closed) {
                        observer.complete();
                    }
                }
            });
            return function () {
                isComplete = true;
                if (!resultSubp.closed) {
                    resultSubp.unsubscribe();
                }
                if (subp !== undefined && !subp.closed) {
                    subp.unsubscribe();
                }
            };
        });
    };
}
exports.bufferMap = bufferMap;
