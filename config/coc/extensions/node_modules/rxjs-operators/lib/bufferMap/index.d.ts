import { Observable } from 'rxjs';
/**
 * will cache the source observable values until inner observable is complete,
 * then the cache values will trigger as array
 */
export declare function bufferMap<T, K>(fn: (args: T[]) => Observable<K>): (preObs: Observable<T>) => Observable<K>;
